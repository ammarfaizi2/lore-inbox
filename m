Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbWG1QeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWG1QeJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 12:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbWG1QeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 12:34:09 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:31718 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750952AbWG1QeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 12:34:08 -0400
Subject: Re: [PATCH] amd74xx: implement suspend-to-ram
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, Vojtech Pavlik <vojtech@suse.cz>,
       Jason Lunz <lunz@falooley.org>
In-Reply-To: <200607281646.31207.rjw@sisk.pl>
References: <200607281646.31207.rjw@sisk.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Jul 2006 17:51:55 +0100
Message-Id: <1154105517.13509.153.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-07-28 am 16:46 +0200, ysgrifennodd Rafael J. Wysocki:
> From: Jason Lunz <lunz@falooley.org>
> 
> The amd74xx driver needs to reprogram each drive's PIO timings as well
> as the DMA timings on resume from s2ram.  Otherwise, my
> nforce3-150-based laptop hangs hard when ide_start_power_step() calls
> drive->hwif->ide_dma_check(drive).

NAK

This beings in the IDE power step code. You should do that as a step
before the win_idleimmediate I suspect. Theory is right, diagnosis is
right, implementation is in the wrong place.

You'll make a lot more people happy by fixing it in ide-io

Alan


