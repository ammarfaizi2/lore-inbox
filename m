Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbTKCQtv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 11:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbTKCQtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 11:49:51 -0500
Received: from intra.cyclades.com ([64.186.161.6]:2688 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262104AbTKCQtq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 11:49:46 -0500
Date: Mon, 3 Nov 2003 14:46:48 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.23-pre9
In-Reply-To: <m365i15x4k.fsf@defiant.pm.waw.pl>
Message-ID: <Pine.LNX.4.44.0311031445190.16941-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 3 Nov 2003, Krzysztof Halasa wrote:

> Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:
> 
> > Here goes -pre9. Only bugfixes will be accepted till 2.4.24-pre now.
> 
> Would you (try to) accept a patch from me if I fix the following?
> 
> Modular IDE is still broken:
> hq:/usr/src/linux-hq# /sbin/depmod -ae
> depmod: *** Unresolved symbols in .../kernel/drivers/ide/ide-core.o
> depmod:         ide_wait_hwif_ready
> depmod:         ide_probe_for_drive
> depmod:         ide_probe_reset
> depmod:         ide_tune_drives
> 
> This is a circular dependency - ide-core.o wants them and they are exported
> by ide-probe.o which wants things from ide-core.o.
>
> Compilation on one of my systems produces (gcc 3.3.1):
> *** md5sum: WARNING: 1 of 13 computed checksums did NOT match
> 
> (this is probably the ISDN source file checksum - we should update MD5
> checksum or drop this checking at all).
> 
> vt.c: In function `do_kdsk_ioctl':
> vt.c:166: warning: comparison is always false due to limited range of data type
> vt.c: In function `do_kdgkb_ioctl':
> vt.c:283: warning: comparison is always false due to limited range of data type
> 
> Probably older gcc is more quiet here.
> 
> keyboard.c: In function `do_fn':
> keyboard.c:640: warning: comparison is always true due to limited range of data
> type
> string.c:384: warning: conflicting types for built-in function `bcopy'
> process.c: In function `machine_restart':
> process.c:426: warning: use of memory input without lvalue in asm operand 0 is deprecated
> time.c:433: warning: `do_gettimeoffset_cyclone' defined but not used
> 
> Modules:
> 
> inode.c:198: warning: `ncp_symlink_inode_operations' defined but not used
> ioctl.c: In function `smb_ioctl':
> ioctl.c:34: warning: comparison is always false due to limited range of data type
> ioctl.c:34: warning: comparison is always false due to limited range of data type
> ioctl.c:34: warning: comparison is always false due to limited range of data type
> ioctl.c:34: warning: comparison is always false due to limited range of data type

Yes I'll accept patches for 2.4.24-pre. You probably should talk to Alan 
about the IDE one.

