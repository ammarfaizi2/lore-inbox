Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263494AbTICRVQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 13:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264123AbTICRTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 13:19:44 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:40977 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S264115AbTICRTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 13:19:11 -0400
Date: Wed, 3 Sep 2003 14:21:32 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
X-X-Sender: marcelo@logos.cnet
To: Sebastian Reichelt <SebastianR@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.4.21] orinoco_cs card reinsertion
In-Reply-To: <20030831160544.2d342b72.SebastianR@gmx.de>
Message-ID: <Pine.LNX.4.44.0309031420480.6102-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 31 Aug 2003, Sebastian Reichelt wrote:

> Hello!
> 
> After switching from 2.4.20 to 2.4.21 (Debian unstable package
> kernel-source-2.4.21-5), my wireless LAN PCMCIA card stopped working
> when I hot-removed and reinserted it. I got these messages in
> /var/log/syslog, plus a high beep on removal and a high and then a low
> beep on reinsertion:
> 
> Upon removal:
> Aug 29 16:00:41 SebastianL2 kernel: orinoco_lock() called with
> hw_unavailable (dev=cf34b800)
> 
> Upon reinsertion:
> Aug 29 16:00:44 SebastianL2 cardmgr[192]: socket 0: ZCOMAX
> AirRunner/XI-300
> Aug 29 16:00:44 SebastianL2 kernel: GetNextTuple(). No matching CIS
> configuration, maybe you need the ignore_cis_vcc=1 parameter.
> Aug 29 16:00:44 SebastianL2 kernel: orinoco_cs: GetFirstTuple: No more
> items
> Aug 29 16:00:45 SebastianL2 cardmgr[192]: get dev info on socket 0
> failed: Resource temporarily unavailable
> 
> I looked at the changes between the two kernels, in orinoco.c,
> orinoco_cs.c, and hermes.c, and it seems that quite a bit of code was
> restructured. So unfortunately, I cannot narrow it down to a single
> change that caused this. The attached patch fixes the problem for me,
> but it is NOT a simple copy from the old driver, and it may not be
> correct at all. However, it might give someone a hint about what went
> wrong. Anyway, even with this patch, I still get the "orinoco_lock()
> called with hw_unavailable" message when I remove the card.
> 
> Sorry if I'm posting a patch for a problem that has already been fixed
> in 2.4.22. The Debian package is still at 2.4.21, and I don't know
> anything about the Debian patches and why they are needed, etc. If I can
> just install a kernel from kernel.org, I will do this, and try to see if
> the problem is still there (I can see an item "orinoco driver update"
> in the changelog, but it's not specific). Should I also install a 2.6
> kernel and check?

Sebastian,

Can you please try 2.4.22? It contains orinoco changes including in the 
area you changed. 

