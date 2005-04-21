Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVDUOFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVDUOFq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 10:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVDUOFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 10:05:46 -0400
Received: from ns2.suse.de ([195.135.220.15]:14549 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261365AbVDUOFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 10:05:39 -0400
Date: Thu, 21 Apr 2005 16:05:37 +0200
From: Karsten Keil <kkeil@suse.de>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, linus@osdl.org, Patrick McHardy <kaber@trash.net>
Subject: Re: fix for ISDN ippp filtering
Message-ID: <20050421140537.GB23653@pingi3.kke.suse.de>
Mail-Followup-To: linux-kernel@vger.kernel.org, akpm@osdl.org,
	linus@osdl.org, Patrick McHardy <kaber@trash.net>
References: <20050421130735.GA23653@pingi3.kke.suse.de> <4267A7E1.7010904@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4267A7E1.7010904@trash.net>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.8-24.10-default i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2005 at 03:17:21PM +0200, Patrick McHardy wrote:
> Karsten Keil wrote:
> >Hi,
> >
> >We do not longer use DLT_LINUX_SLL for activ/pass filters but 
> >DLT_PPP_WITHDIRECTION
> >witch need 1 as outbound flag.
> >Please apply.
> 
> Won't this break compatibility with old ipppd binaries?
> 

Not really, since such a version was never in our I4L CVS and never
released by isdn4linux. It was my fault that this wrong temporary
attempt to solve the filtering problem was pushed into the kernel.
The new version is still compatible to the old filtering using
DLT_PPP (with libpcap 0.7x version) with was the previous version.
The DLT_LINUX_SLL solution did break compatibility and was rejected
because of this for PPP, but I did miss to revert the ISDN kernel
part in time, so it simple do not work today.

 
-- 
Karsten Keil
SuSE Labs
ISDN development
