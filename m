Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbVG3WW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbVG3WW6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 18:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263138AbVG3WW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 18:22:58 -0400
Received: from gold.veritas.com ([143.127.12.110]:7504 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S263117AbVG3WW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 18:22:57 -0400
Date: Sat, 30 Jul 2005 23:24:40 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>, linux-kernel@vger.kernel.org
Subject: Re: revert yenta free_irq on suspend
In-Reply-To: <200507310000.10229.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.61.0507302318090.5286@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0507301952350.3319@goblin.wat.veritas.com>
 <200507302249.55409.rjw@sisk.pl> <Pine.LNX.4.61.0507302231280.4946@goblin.wat.veritas.com>
 <200507310000.10229.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 30 Jul 2005 22:22:56.0668 (UTC) FILETIME=[3C51CDC0:01C59555]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Jul 2005, Rafael J. Wysocki wrote:
> On Saturday, 30 of July 2005 23:32, Hugh Dickins wrote:
> > On Sat, 30 Jul 2005, Rafael J. Wysocki wrote:
> > > 
> > > Could you please send the /proc/interrupts from your box?
> > 
> >  11:      57443          XT-PIC  yenta, yenta, eth0
> 
> Thanks.  It looks like eth0 gets a yenta's interrupt and goes awry.
> Could you please tell me what driver the eth0 is?

CONFIG_VORTEX drivers/net/3c59x.c:
0000:02:00.0: 3Com PCI 3c905C Tornado at 0xec80. Vers LK1.1.19
