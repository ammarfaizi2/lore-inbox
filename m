Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286336AbRL0QSw>; Thu, 27 Dec 2001 11:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286338AbRL0QSm>; Thu, 27 Dec 2001 11:18:42 -0500
Received: from h55p103-3.delphi.afb.lu.se ([130.235.187.176]:27038 "EHLO gin")
	by vger.kernel.org with ESMTP id <S286336AbRL0QS1>;
	Thu, 27 Dec 2001 11:18:27 -0500
Date: Thu, 27 Dec 2001 17:18:23 +0100
To: Martin Jonsson <marty@rty.nu>
Cc: andersg@0x63.nu, linux-kernel@vger.kernel.org
Subject: Re: kiB
Message-ID: <20011227161823.GC11106@h55p111.delphi.afb.lu.se>
In-Reply-To: <20011227160557.GB11106@h55p111.delphi.afb.lu.se> <Pine.LNX.4.42.0112271710380.865-100000@hawaii.cyberzone.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.42.0112271710380.865-100000@hawaii.cyberzone.lan>
User-Agent: Mutt/1.3.24i
From: andersg@0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2001 at 05:14:25PM +0100, Martin Jonsson wrote:
> > -       fprintf (stderr, "System is %d kB\n", sz/1024);
> > +       fprintf (stderr, "System is %d kiB\n", sz/1024);
> 
> Shouldn't that be "KiB" when talking about kibibytes?

yes, ofcourse.. new patch attached :)

-- 

//anders/g

diff -ru linux-2.5.2-pre2/arch/i386/boot/tools/build.c linux-2.5.2-pre2-lvmfix/arch/i386/boot/tools/build.c
--- linux-2.5.2-pre2/arch/i386/boot/tools/build.c	Mon Jul  2 22:56:40 2001
+++ linux-2.5.2-pre2-lvmfix/arch/i386/boot/tools/build.c	Thu Dec 27 17:13:20 2001
@@ -148,7 +148,7 @@
 	if (fstat (fd, &sb))
 		die("Unable to stat `%s': %m", argv[3]);
 	sz = sb.st_size;
-	fprintf (stderr, "System is %d kB\n", sz/1024);
+	fprintf (stderr, "System is %d KiB\n", sz/1024);
 	sys_size = (sz + 15) / 16;
 	/* 0x28000*16 = 2.5 MB, conservative estimate for the current maximum */
 	if (sys_size > (is_big_kernel ? 0x28000 : DEF_SYSSIZE))
