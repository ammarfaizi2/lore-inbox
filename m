Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269309AbUJFRPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269309AbUJFRPx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 13:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269320AbUJFRPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 13:15:53 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:16555 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269309AbUJFRPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 13:15:37 -0400
Subject: Re: PROBLEM: 2.6.9-rc3, i8042.c: Can't read CTR while initializing
	i8042
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ronald Moesbergen <r.moesbergen@hccnet.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4161A2C1.8000901@hccnet.nl>
References: <4161A2C1.8000901@hccnet.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097079186.29255.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 06 Oct 2004 17:13:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-10-04 at 20:21, Ronald Moesbergen wrote:
> Hi,
> 
> Since 2.6.9-rc3 (I tested rc3-bk3 also) on 3 out of 10 boots my PS/2 
> keyboard is dead and 'i8042.c: Can't read CTR while initializing i8042' 
> shows up in my logfile. Google found this:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109463125415432&w=2
> 
> which suggests to add i8042.noacpi=1 to my boot parameters, but 
> unfortunately that doesn't help, the kernel doesn't even recognize this 
> option. Reverting back to 2.6.9-rc2 fixes it. The machine is a P4 3Ghz 
> HT, E7205 chipset, ASUS P4P8X board.

For E7xxx systems you need to disable USB legacy support in the BIOS
because SMM only works on the boot processor. There is a patch to
automate it in 2.6.8.1-ac you can also borrow

