Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315266AbSEGADR>; Mon, 6 May 2002 20:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315268AbSEGADQ>; Mon, 6 May 2002 20:03:16 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:17420 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315266AbSEGADQ>; Mon, 6 May 2002 20:03:16 -0400
Date: Tue, 7 May 2002 02:03:04 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 55
In-Reply-To: <3CD64844.20907@evision-ventures.com>
Message-ID: <Pine.LNX.4.21.0205070156580.32715-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 6 May 2002, Martin Dalecki wrote:

> - Consolidate the handling of device ID byte order in one place.
>    This was spotted and patched by Bartomiej onierkiewicz.

Another thing: where is the equivalilent part of this removed code?

-static __inline__ void ide_fix_driveid(struct hd_driveid *id)
-{
-#if defined(CONFIG_AMIGA) || defined (CONFIG_MAC) || defined(M68K_IDE_SWAPW)
-   u_char *p = (u_char *)id;
-   int i, j, cnt;
-   u_char t;
-
-   if (!MACH_IS_AMIGA && !MACH_IS_MAC && !MACH_IS_Q40 && !MACH_IS_ATARI)
-       return;
-#ifdef M68K_IDE_SWAPW
-   if (M68K_IDE_SWAPW)    /* fix bus byteorder first */
-      for (i=0; i < 512; i+=2) {
-        t = p[i]; p[i] = p[i+1]; p[i+1] = t;
-      }
-#endif

bye, Roman

