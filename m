Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268536AbTGLVWd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 17:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268537AbTGLVWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 17:22:32 -0400
Received: from SMTP7.andrew.cmu.edu ([128.2.10.87]:14057 "EHLO
	smtp7.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S268536AbTGLVWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 17:22:31 -0400
Date: Sat, 12 Jul 2003 17:36:57 -0400 (EDT)
From: "Nathaniel W. Filardo" <nwf@andrew.cmu.edu>
To: Martin Sarsale <lists@runa.sytes.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.75 everything looks ok!
In-Reply-To: <20030712155400.4247908f.lists@runa.sytes.net>
Message-ID: <Pine.LNX.4.55L-032.0307121735260.8182@unix47.andrew.cmu.edu>
References: <20030712155400.4247908f.lists@runa.sytes.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If this is your first time running 2.5, that makes sense.  The
modules_install would have taken place running under a 2.4 kernel so
depmod would have called the modutils (2.4) depmod and not generated the
appropriate files.  Calling "depmod -ae" when running under 2.5 should
generate these (stored in /lib/modules/2.5.75/) and allow modprobe to work
again.

Best of luck.
--nwf;

On Sat, 12 Jul 2003, Martin Sarsale wrote:

> Im not sure if you appreciate this kind of messages, but I've just booted linux 2.5.75 and after installing module-init-tools everything works as expected :)
>
> PIII 450
> Realtek 8139 (using 8139too)
> 3 Reiser fs partitions (including root)
> ADSL
>
> I found only one rare thing: when I run "make modules_install" a lot of modules had missing symbols.  Im not sure but it think it has something to do with the crc32 module: when I got the messages about the missing symbols, I hadn't compiled crc32, after that I compiled and loaded it, "make modules_install" worked like a charm
>
> Another thing:
> Using module-init-tools 0.9.13-pre when I try to load any module using modprobe I get a "FATAL: Module module not found":
>
> modprobe crc32
> FATAL: Module crc32 not found.
>
> Instead, I have to use insmod and the full module path (insmod /lib/modules/2.5.75/kernel/lib/crc32.ko  works ok).
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
