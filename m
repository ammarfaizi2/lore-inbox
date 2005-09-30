Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbVI3RPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbVI3RPu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 13:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbVI3RPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 13:15:50 -0400
Received: from smtp810.mail.ukl.yahoo.com ([217.12.12.200]:42606 "HELO
	smtp810.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751201AbVI3RPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 13:15:49 -0400
Subject: Re: 2.6.14-rc2-mm2
From: Grant Wilson <gww@btinternet.com>
To: Badari Pulavarty <pbadari@gmail.com>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1128099298.16275.80.camel@dyn9047017102.beaverton.ibm.com>
References: <20050929143732.59d22569.akpm@osdl.org>
	 <14500000.1128090994@[10.10.2.4]>
	 <1128099298.16275.80.camel@dyn9047017102.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 18:15:51 +0100
Message-Id: <1128100551.22812.2.camel@tlg.swandive.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-30 at 09:54 -0700, Badari Pulavarty wrote:
> On Fri, 2005-09-30 at 07:36 -0700, Martin J. Bligh wrote:
> > Hangs on boot on x86_64 (-mm1 did the same, -git8 is fine)

> > AMD8111: not 100% native mode: will probe irqs later
> > AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
> >     ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:pio, hdb:pio
> >     ide1: BM-DMA at 0x1008-0x100f<4>logips2pp: Detected unknown logitech mouse model 0
> > , BIOS settings: hdc:DMA, hdd:pio
> > input: PS/2 Logitech Mouse on isa0060/serio1
> > -- 0:conmux-control -- time-stamp -- Sep/29/05 15:38:00 --
> 
> I ran into the same issue earlier on my AMD box and 
> found out that
> 
> x86_64-no-idle-tick.patch 
> 
> is causing the problem with IDE drives. No idea why.
> Can you back out x86_64-no-idle-tick* patches and
> try ?

Same problem here and dropping those patches fixes the problem (as it
did for -mm1).  

Grant
-- 
Running Linux 2.6.14-rc2-mm2 on x86_64

