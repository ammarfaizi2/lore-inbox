Return-Path: <linux-kernel-owner+w=401wt.eu-S932356AbXAON5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbXAON5U (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 08:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbXAON5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 08:57:20 -0500
Received: from mx1.suse.de ([195.135.220.2]:34335 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932356AbXAON5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 08:57:20 -0500
Date: Mon, 15 Jan 2007 14:57:18 +0100
From: Karsten Keil <kkeil@suse.de>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: any value to fixing apparent bugs in old ISDN4Linux?
Message-ID: <20070115135718.GC30889@pingi.kke.suse.de>
Mail-Followup-To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0701150634270.1953@CPE00045a9c397f-CM001225dbafb6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701150634270.1953@CPE00045a9c397f-CM001225dbafb6>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.16.21-0.23-smp x86_64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2007 at 06:43:30AM -0500, Robert P. J. Day wrote:
> 
> $ grep -r DE_AOC .
> ./.config:CONFIG_DE_AOC=y
> ./drivers/isdn/hisax/l3dss1.c:#ifdef HISAX_DE_AOC
> ./drivers/isdn/hisax/l3dss1.c:#else  /* not HISAX_DE_AOC */
> ./drivers/isdn/hisax/l3dss1.c:#endif /* not HISAX_DE_AOC */
> ./drivers/isdn/hisax/Kconfig:config DE_AOC
> 
>   it seems like there's a name mismatch between the config variable
> and the one that's being tested, no?
> 
>   OTOH, since that code *is* in the allegedly obsolete old ISDN4Linux
> code, perhaps that entire part of the tree can just be junked.  but if
> it's sticking around, it should probably be fixed.
> 


Yes thanks for discover this. Since the code only affect the
analyse of the AOC info which is pure information only without real
function it was not detected before.

-- 
Karsten Keil
SuSE Labs
ISDN development
