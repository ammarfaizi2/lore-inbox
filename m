Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292375AbSBYWlz>; Mon, 25 Feb 2002 17:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292368AbSBYWll>; Mon, 25 Feb 2002 17:41:41 -0500
Received: from [208.48.139.185] ([208.48.139.185]:10920 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S292370AbSBYWkX>; Mon, 25 Feb 2002 17:40:23 -0500
Date: Mon, 25 Feb 2002 14:40:15 -0800
From: David Rees <dbr@greenhydrant.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18 - Full tarball is OK
Message-ID: <20020225144015.A32006@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200202252149.g1PLnwe13182@directcommunications.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200202252149.g1PLnwe13182@directcommunications.net>; from chris@directcommunications.net on Mon, Feb 25, 2002 at 09:49:58PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2002 at 09:49:58PM +0000, Chris Funderburg wrote:
> 
> FYI - The full tarball already has the missing patch...
> 
> So, I think, it's only patch-2.4.18 that has the problem...

Uh, no, it doesn't.  Using linux-2.4.18.tar.bz2 dated Feb 25, 2002 11:40am:

diff -urN linux-2.4.18-rc4/Makefile linux-2.4.18/Makefile
--- linux-2.4.18-rc4/Makefile	Mon Feb 25 14:35:52 2002
+++ linux-2.4.18/Makefile	Mon Feb 25 11:37:52 2002
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 18
-EXTRAVERSION = -rc4
+EXTRAVERSION =
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
diff -urN linux-2.4.18-rc4/fs/binfmt_elf.c linux-2.4.18/fs/binfmt_elf.c
--- linux-2.4.18-rc4/fs/binfmt_elf.c	Mon Feb 25 14:35:55 2002
+++ linux-2.4.18/fs/binfmt_elf.c	Mon Feb 25 11:38:08 2002
@@ -564,9 +564,6 @@
 			// printk(KERN_WARNING "ELF: Ambiguous type, using
ELF\n");
 			interpreter_type = INTERPRETER_ELF;
 		}
-	} else {
-		/* Executables without an interpreter also need a
personality  */
-		SET_PERSONALITY(elf_ex, ibcs2_interpreter);
 	}
 
 	/* OK, we are done with that, now set up the arg stuff,
