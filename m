Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285593AbRLYQib>; Tue, 25 Dec 2001 11:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285633AbRLYQiW>; Tue, 25 Dec 2001 11:38:22 -0500
Received: from hera.cwi.nl ([192.16.191.8]:48794 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S285593AbRLYQiM>;
	Tue, 25 Dec 2001 11:38:12 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 25 Dec 2001 16:38:11 GMT
Message-Id: <UTC200112251638.QAA94646.aeb@cwi.nl>
To: jlladono@pie.xtec.es
Subject: Re: 2.4.x kernels, big ide disks and old bios
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josep Lladonosa i Capell:

> Linux adopts the 'false' geometry (65530/16/63) ) to bypass the bios
> boot.

You can see that this is the wrong way around.
When you start your computer, first the BIOS boots, then Linux.
But maybe you mean to say that you set a jumper on the disk
so as to bypass the BIOS boot problem, and that as a result
also Linux sees a smaller disk?

> hdc: IC35L060AVER07-0, ATA DISK drive
> hdc: 66055247 sectors (33820 MB) w/1916KiB Cache, CHS=119150/16/63,

Funny. Where did this CHS come from? Did you give boot parameters?

> setmax.c does its job for my ide ibm - 60Gb, but kernel
> leaves bios parameters - 32Gb

Can you be more explicit? What precisely do you do?
Call setmax in a boot script? And afterwards you can access
the entire disk, but some proc files still mention the old
geometry? Or are there any real problems?
What precisely do you mean by "kernel leaves bios parameters"?


Santiago Garcia Mantinan:

: What I'm using is change the geometry after the boot and before any
: partition besides root is mounted, I do this at the beginning of
: checkroot.sh by calling "/sbin/setmax -d 0 /dev/hda"
: This works ok for me, of course you can have other solutions.

Good to hear that it works OK. Sooner or later setmax or something
similar must become part of the standard kernel, but so far I've
gotten almost no feedback. Can you give the disk manufacturer and model
(mail aeb@cwi.nl)?

Andries
