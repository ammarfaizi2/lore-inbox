Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUHFMmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUHFMmX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 08:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265489AbUHFMmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 08:42:23 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:58119 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261474AbUHFMmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 08:42:21 -0400
Date: Fri, 6 Aug 2004 14:30:56 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Herbert Xu <herbert@gondor.apana.org.au>,
       greearb@candelatech.com, akpm@osdl.org, alan@redhat.com,
       jgarzik@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: VLAN support for 3c59x/3c90x
Message-ID: <20040806123056.GA23005@alpha.home.local>
References: <20040730121004.GA21305@alpha.home.local> <E1BqkzY-0003mK-00@gondolin.me.apana.org.au> <20040731083308.GA24496@alpha.home.local> <410B67B1.4080906@pobox.com> <20040731101152.GG1545@alpha.home.local> <20040731141222.GJ2429@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040731141222.GJ2429@mea-ext.zmailer.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

On Sat, Jul 31, 2004 at 05:12:22PM +0300, Matti Aarnio wrote:
<...> 
> In the receive descriptors there might appear a TL bit (Frame Too Long),
> which is just telling that frame size exceeds 1518 bytes.
> If RW (Receive Watchdog; RDES0<4>) has tripped, then there is at least
> 2048 bytes long frame, most likely longer than 2560 bytes.
> 
> Based on my reading of  ds21143hrm.pdf  (copy of which I have), I do
> think it is safe to just receive larger frames with Tulip, and IGNORE
> the "TL" bit.
> 
> Receiving 1522 byte frames from ethernet with Tulip should be trivial.
> Will that be true with 21140 -- oddly I don't have a copy of 21140 HRM
> in PDF form...  Possibly I got it in paper long ago.

I've just found a document on intel's site comparing 21140 and 21143.
Its reference is 27810701 and its title : "21140-AF to 21143-xD Upgrade".

Since there's nothing about the subject in this document, I assume that
they behave equally. I don't have the time right now, but probably will
during this week-end to make new tests with the doc. For those
interested, the 21143 HRM's reference is 27807401.

Regards,
Willy

