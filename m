Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbTBXWrF>; Mon, 24 Feb 2003 17:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262040AbTBXWrF>; Mon, 24 Feb 2003 17:47:05 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34578 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261996AbTBXWrD>; Mon, 24 Feb 2003 17:47:03 -0500
Date: Mon, 24 Feb 2003 14:52:08 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       <ncunningham@clear.net.nz>
Subject: Re: swsusp and S3 fixes
In-Reply-To: <20030221094850.GA18896@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0302241450060.18519-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pavel,
 your patch causes

	arch/i386/kernel/dmi_scan.c:482: warning: `reset_videobios_after_s3' defined but not used
	make[1]: warning: jobserver unavailable: using -j1.  Add `+' to parent make rule.
	arch/i386/kernel/built-in.o: In function `reset_videomode_after_s3':
	arch/i386/kernel/built-in.o(.init.text+0x1e07): undefined reference to `acpi_video_flags'
	arch/i386/kernel/built-in.o: In function `reset_videobios_after_s3':
	arch/i386/kernel/built-in.o(.init.text+0x1e17): undefined reference to `acpi_video_flags'
	make: *** [.tmp_vmlinux1] Error 1

for me, with neither ACPI not SW_SUSPEND configured.

Don't call patches like this "trivial" if they haven't even been 
properly tested. 

			Linus

