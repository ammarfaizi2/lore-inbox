Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWB1TWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWB1TWu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 14:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWB1TWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 14:22:50 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:40464 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932452AbWB1TWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 14:22:49 -0500
Date: Tue, 28 Feb 2006 20:22:40 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: xxxx <toxicitycom@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make dep -problem
Message-ID: <20060228192240.GB10235@mars.ravnborg.org>
References: <1141099751.29028.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141099751.29028.1.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 04:09:11AM +0000, xxxx wrote:
> *** Check the top-level Makefile for additional configuration.
> *** Next, you must run 'make dep'.
> 
> make[1]: Entering directory `/home/matt/uClinux-workspace/uClinux-dist'
> make ARCH=m68knommu CROSS_COMPILE=m68k-elf- -C linux-2.4.x menuconfig
> make[2]: Entering directory `/home/matt/uClinux-workspace/uClinux-2.4.x'
> rm -f include/asm
> ( cd include ; ln -sf asm-m68knommu asm)
> make -C scripts/lxdialog all
> make[3]: Entering directory
> `/home/matt/uClinux-workspace/uClinux-2.4.x/scripts/lxdialog'
> make[3]: Leaving directory
> `/home/matt/uClinux-workspace/uClinux-2.4.x/scripts/lxdialog'
> /bin/sh scripts/Menuconfig arch/m68knommu/config.in
> Using defaults found in .config
> Preparing scripts: functions, parsing../MCmenu0: line 106: unexpected
> EOF while looking for matching `''
> ./MCmenu0: line 110: syntax error: unexpected end of file
> ......................................................................done.
> 
> 
> Menuconfig has encountered a possible error in one of the kernel's
> configuration files and is unable to continue.  Here is the error
> report:
> 
>  Q> scripts/Menuconfig: line 832: MCmenu0: command not found
> 
> Please report this to the maintainer <mec@shout.net>.  You may also
> send a problem report to <linux-kernel@vger.kernel.org>.
> 
> Please indicate the kernel version you are trying to configure and
> which menu you were trying to enter when this error occurred.
> 
> make[2]: *** [menuconfig] Error 1
> make[2]: Leaving directory `/home/matt/uClinux-workspace/uClinux-2.4.x'
> make[1]: *** [linux_menuconfig] Error 2
> make[1]: Leaving directory `/home/matt/uClinux-workspace/uClinux-dist'
> make: *** [menuconfig] Error 2
> [matt@localhost uClinux-dist]$

There is a buig in one of your Config.in files.
It used to be ALSA that caused this.

Try to disable stuff and see when it starts to work.
If it is ALSA then patches was floating around a year ago or so.

	Sam
