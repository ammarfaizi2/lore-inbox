Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266186AbSKONQ4>; Fri, 15 Nov 2002 08:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266203AbSKONQ4>; Fri, 15 Nov 2002 08:16:56 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:24017 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266186AbSKONQ4>; Fri, 15 Nov 2002 08:16:56 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200211151323.gAFDNlt01818@devserv.devel.redhat.com>
Subject: Re: 2.4.20-rc1-ac3 compile warnings/errors (test)
To: dlister@yossman.net (Brian Davids)
Date: Fri, 15 Nov 2002 08:23:47 -0500 (EST)
Cc: linux-kernel@vger.kernel.org (linux-kernel), alan@redhat.com (Alan Cox)
In-Reply-To: <3DD4A149.4030707@yossman.net> from "Brian Davids" at Nov 15, 2002 02:24:57 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   -nostdinc -iwithprefix include -DKBUILD_BASENAME=setup_pci 
> -DEXPORT_SYMTAB -c setup-pci.c
> setup-pci.c: In function `ide_setup_pci_device':
> setup-pci.c:704: warning: unused variable `index_list'
> setup-pci.c: In function `ide_setup_pci_devices':
> setup-pci.c:711: warning: unused variable `index_list'
> setup-pci.c:712: warning: unused variable `index_list2'

I should clean that up

> -DEXPORT_SYMTAB -c pnpbios_core.c
> {standard input}: Assembler messages:
> {standard input}:16: Warning: indirect lcall without `*'

These are intended. We have a problem where

	very old binutils accepts lcall with * but misassembles it
	newer binutils assembles both properly
	latest binutils warns about the *

>   -nostdinc -iwithprefix include -DKBUILD_BASENAME=rmap  -c -o rmap.o rmap.c
> In file included from rmap.c:31:
> /usr/src/linux-2.4.20-rc1-ac3/include/asm/smplock.h:17:1: warning: 
> "kernel_locked" redefined

Weird indeed. are you trying to build SMP or non SMP ?
