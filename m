Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266234AbUFPKls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266234AbUFPKls (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 06:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266236AbUFPKls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 06:41:48 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:39893 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266234AbUFPKlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 06:41:36 -0400
Subject: Re: ld segfault at end of 2.6.6 compile
From: Geoff Mishkin <gmishkin@acs.bu.edu>
Reply-To: gmishkin@bu.edu
To: linux-kernel@vger.kernel.org
Cc: Harald Dunkel <harald.dunkel@t-online.de>
In-Reply-To: <40CFE50D.10308@t-online.de>
References: <1087352698.8671.23.camel@amsa>  <40CFE50D.10308@t-online.de>
Content-Type: text/plain
Message-Id: <1087382494.8675.32.camel@amsa>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 16 Jun 2004 06:41:35 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I couldn't find exactly what I was looking for in the BIOS utility (IBM
ThinkPad T42), but I turned on Diagnostics mode and the RAM check, so at
boot it checked the RAM, which all turned out okay.

Still having the problem, though.

			--Geoff Mishkin <gmishkin@bu.edu>


On Wed, 2004-06-16 at 02:13, Harald Dunkel wrote:
> Geoff Mishkin wrote:
> > I'm getting the
> > 
> > make: *** [.tmp_vmlinux1] Error 139
> > 
> > problem with kernel 2.6.6.  It works fine on one of my computer, but not
> > the other.
> > 
> > The full line is
> > 
> > ld -m elf_i386  -T arch/i386/kernel/vmlinux.lds.s
> > arch/i386/kernel/head.o arch/i386/kernel/init_task.o   init/built-in.o
> > --start-group  usr/built-in.o arch/i386/kernel/built-in.o 
> > arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o 
> > kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o 
> > security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a 
> > lib/built-in.o  arch/i386/lib/built-in.o  drivers/built-in.o 
> > sound/built-in.o  arch/i386/pci/built-in.o  arch/i386/power/built-in.o 
> > net/built-in.o --end-group  -o .tmp_vmlinux1
> > make: *** [.tmp_vmlinux1] Error 139
> > 
> 
> Error 139 is a SEGV somewhere in a subprocess. Linker errors
> like this might be an indicator for problems with your physical
> memory.
> 
> My suggestion would be to enter your PC's BIOS setup at boot
> time and verify the RAM access timing. Maybe it was set too
> optimistic.
> 
> 
> Good luck
> 
> Harri

