Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265909AbTAIMCz>; Thu, 9 Jan 2003 07:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265960AbTAIMCz>; Thu, 9 Jan 2003 07:02:55 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:45770 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265909AbTAIMCy>; Thu, 9 Jan 2003 07:02:54 -0500
Date: Thu, 9 Jan 2003 13:11:32 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.5 patch] correct help text for LOG_BUF_SHIFT
Message-ID: <20030109121132.GP6626@fs.tum.de>
References: <Pine.LNX.4.44.0301082033410.1438-100000@penguin.transmeta.com> <Pine.GSO.4.21.0301091202511.25052-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0301091202511.25052-100000@vervain.sonytel.be>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2003 at 12:04:46PM +0100, Geert Uytterhoeven wrote:
> On Wed, 8 Jan 2003, Linus Torvalds wrote:
> > Andrew Morton <akpm@digeo.com>:
> >   o move LOG_BUF_SIZE to header/config
> 
> I find the config a bit confusing:
> 
> | Kernel log buffer size (128 KB, 64 KB, 32 KB, 16 KB, 8 KB, 4 KB) [16 KB] (NEW) ?
> | Select kernel log buffer size from this list (power of 2).
> | Defaults:  17 (=> 128 KB for S/390)
> |            16 (=> 64 KB for x86 NUMAQ or IA-64)
> |            15 (=> 32 KB for SMP)
> |            14 (=> 16 KB for uniprocessor)
> | 
> | Kernel log buffer size (128 KB, 64 KB, 32 KB, 16 KB, 8 KB, 4 KB) [16 KB] (NEW) 
> 
> E.g. should I enter `14' or `16 KB' (or `16') for `16 KB'?

After reading init/Kconfig it seems the following was intended:

--- linux-2.5.55/init/Kconfig.old	2003-01-09 13:06:43.000000000 +0100
+++ linux-2.5.55/init/Kconfig	2003-01-09 13:08:44.000000000 +0100
@@ -89,11 +89,11 @@
 	default LOG_BUF_SHIFT_15 if SMP
 	default LOG_BUF_SHIFT_14
 	help
-	  Select kernel log buffer size from this list (power of 2).
-	  Defaults:  17 (=> 128 KB for S/390)
-		     16 (=> 64 KB for x86 NUMAQ or IA-64)
-	             15 (=> 32 KB for SMP)
-	             14 (=> 16 KB for uniprocessor)
+	  Select kernel log buffer size from this list.
+	  Defaults:  128 KB for S/390
+		     64 KB for x86 NUMAQ or IA-64
+	             32 KB for SMP
+	             16 KB for uniprocessor
 
 config LOG_BUF_SHIFT_17
 	bool "128 KB"


> Gr{oetje,eeting}s,
> 
> 						Geert

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

