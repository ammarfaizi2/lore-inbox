Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268340AbUJOTmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268340AbUJOTmZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 15:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268392AbUJOTmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 15:42:25 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:10448 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268340AbUJOTmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 15:42:11 -0400
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <416FB29A.11731.1C46848@localhost>
References: <m3655cjc1r.fsf@averell.firstfloor.org>
	 <416FB29A.11731.1C46848@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097865570.10133.187.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 15 Oct 2004 19:39:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-10-15 at 19:20, Kendall Bennett wrote:
> That works great on x86, but this solution was developed for PowerPC and 
> MIPS embedded systems development not x86 desktop systems. For those 
> platforms you either need a boot loader that can bring up the system into 
> graphics mode (possible with U-Boot) or to init the video right when the 
> framebuffer console driver is brought up.

Right there are certainly cases where you need to do stuff very early.
Even then you may benefit because you can keep the kernel side init
pretty basic and also marked "__init" so it is freed post boot.

> >From the sound of it that might be too early to spawn a user mode 
> process?

Do the embedded folks want the kernel boot messages via the display or
are they happy with that via debug port/serial anyway. If so is it an
issue ? You can bring up the video at the point user space begins.

