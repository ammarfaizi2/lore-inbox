Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317323AbSFGTL5>; Fri, 7 Jun 2002 15:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317326AbSFGTL4>; Fri, 7 Jun 2002 15:11:56 -0400
Received: from [195.39.17.254] ([195.39.17.254]:13985 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317323AbSFGTLz>;
	Fri, 7 Jun 2002 15:11:55 -0400
Date: Fri, 7 Jun 2002 13:01:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Cleanup i386 <linux/init.h> abuses
Message-ID: <20020607110145.GA9975@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0206021853030.1383-100000@penguin.transmeta.com> <20020605163614.GF1335@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The following patch cleans up the i386 usage of <linux/init.h>.
> This remove <linux/init.h> from <asm-i386/system.h> which did not need
> it, <asm-i386/highmem.h> which only had it due to an extern using
> __init, which is not needed.
> This adds <linux/init.h> to <asm-i386/bugs.h> which actually has
> numerous __init functions and adds <linux/init.h> to 9 files inside of
> arch/i386 which were indirectly including <linux/init.h> previously.


@@ -33,7 +32,7 @@
 extern pgprot_t kmap_prot;
 extern pte_t *pkmap_page_table;

-extern void kmap_init(void) __init;
+extern void kmap_init(void);

 /*
  * Right now we initialize only a single pte table. It can be
extended


__init is usefull as a documentation... Perhaps adding /* This is
__init function */ would be good.
									Pavel

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
