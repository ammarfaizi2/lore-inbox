Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267404AbUGNPBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267404AbUGNPBI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 11:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267490AbUGNO5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 10:57:46 -0400
Received: from styx.suse.cz ([82.119.242.94]:11392 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S267441AbUGNO5a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 10:57:30 -0400
Date: Wed, 14 Jul 2004 16:59:12 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ipw2100 wireless driver
Message-ID: <20040714145912.GA2413@ucw.cz>
References: <2hQr1-62p-23@gated-at.bofh.it> <2hRQ5-7bn-9@gated-at.bofh.it> <m3fz7usmvb.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3fz7usmvb.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 04:07:52PM +0200, Andi Kleen wrote:

> Vojtech Pavlik <vojtech@suse.cz> writes:
> >
> > Wouldn't "struct sk_buff **fragments" be a more correct fix?
> 
> No, that would be a pointer to an array instead of the array itself.
> 
> Completely different thing.

Indeed.

> The best would be struct sk_buff *fragments[0]; 

Agreed. It's not a very nice construction anyway.

> [] here is C99, which 2.95 didn't even attempt to support.
> 
> -Andi
> 
> 
> >> --- ipw2100-ofic/ieee80211.h	2004-07-09 06:32:17.000000000 +0200
> >> +++ ipw2100-0.49/ieee80211.h	2004-07-14 13:18:50.000000000 +0200
> >> @@ -440,7 +440,7 @@
> >>  	u16 reserved;
> >>  	u16 frag_size;
> >>  	u16 payload_size;
> >> -	struct sk_buff *fragments[];
> >> +	struct sk_buff *fragments[1];
> 
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
