Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbTKVRVs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 12:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbTKVRVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 12:21:48 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:34434
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262546AbTKVRVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 12:21:46 -0500
Date: Sat, 22 Nov 2003 12:20:29 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Remi Colinet <remi.colinet@wanadoo.fr>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9-mm5 : compile error
In-Reply-To: <3FBF99E6.1070402@wanadoo.fr>
Message-ID: <Pine.LNX.4.53.0311221218350.2498@montezuma.fsmlabs.com>
References: <3FBF5C79.5050409@wanadoo.fr> <Pine.LNX.4.53.0311220946280.2498@montezuma.fsmlabs.com>
 <3FBF99E6.1070402@wanadoo.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Nov 2003, Remi Colinet wrote:

> >Index: linux-2.6.0-test9-mm5/arch/i386/kernel/process.c
> >===================================================================
> >RCS file: /build/cvsroot/linux-2.6.0-test9-mm5/arch/i386/kernel/process.c,v
> >retrieving revision 1.1.1.1
> >diff -u -p -B -r1.1.1.1 process.c
> >--- linux-2.6.0-test9-mm5/arch/i386/kernel/process.c	21 Nov 2003 20:59:15 -0000	1.1.1.1
> >+++ linux-2.6.0-test9-mm5/arch/i386/kernel/process.c	21 Nov 2003 22:20:00 -0000
> >@@ -50,6 +50,7 @@
> > #include <asm/desc.h>
> > #include <asm/tlbflush.h>
> > #include <asm/cpu.h>
> >+#include <asm/atomic_kmap.h>
> > #ifdef CONFIG_MATH_EMULATION
> > #include <asm/math_emu.h>
> > #endif
> 
> Just a point : in the file arch/i383/process.c, I added the  following 
> lines.
> 
> #include <asm/tlbflush.h>
> #include <asm/cpu.h>

That was already in there.

> My original processs.c file seems to be a little be bit different from 
> yours (?).
> The following line was already in the process.c file.
> 
> +#include <asm/atomic_kmap.h>

Hmm that's strange, can you verify your tree and i'll do the same. There 
are two discrepancies.
