Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262724AbVE1Myq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262724AbVE1Myq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 08:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbVE1Myp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 08:54:45 -0400
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:39906 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S262724AbVE1Mye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 08:54:34 -0400
Date: Sat, 28 May 2005 14:54:30 +0200
From: =?iso-8859-1?Q?Pozs=E1r_Bal=E1zs?= <pozsy@uhulinux.hu>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Sean M. Burke" <sburke@cpan.org>, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: PATCH: "Ok" -> "OK" in messages
Message-ID: <20050528125430.GB3870@ojjektum.uhulinux.hu>
References: <42985251.6030006@cpan.org> <1117279792.32118.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117279792.32118.11.camel@localhost.localdomain>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2005 at 12:29:52PM +0100, David Woodhouse wrote:
> On Sat, 2005-05-28 at 03:13 -0800, Sean M. Burke wrote:
> > The English interjection "OK" is misspelled as "Ok" in a dozen
> > messages in the Linux kernel.  The following patch corrects
> > those typos from "Ok" to "OK".  It affects no comments or
> > symbol-names -- and it stops me wanting to gnaw my fingers off every
> > time I see "Ok, booting the kernel."!
> 
> If you're going to do that, you might as well fix 'Uncompressing Linux'
> to 'Decompressing Linux' too, and stop _me_ from being annoyed as well.

While we are at it, what about changing this string to something 
language-neutral, like this:

diff -Naurdp a/arch/i386/boot/compressed/misc.c b/arch/i386/boot/compressed/misc.c
--- a/arch/i386/boot/compressed/misc.c	2004-04-04 05:37:23.000000000 +0200
+++ b/arch/i386/boot/compressed/misc.c	2004-05-09 23:18:06.000000000 +0200
@@ -10,6 +10,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/version.h>
 #include <linux/vmalloc.h>
 #include <linux/tty.h>
 #include <video/edid.h>
@@ -373,9 +374,9 @@ asmlinkage int decompress_kernel(struct 
 	else setup_output_buffer_if_we_run_high(mv);
 
 	makecrc();
-	putstr("Uncompressing Linux... ");
+	putstr("Linux " UTS_RELEASE);
 	gunzip();
-	putstr("Ok, booting the kernel.\n");
+	putstr("\n");
 	if (high_loaded) close_output_buffer_if_we_run_high(mv);
 	return high_loaded;
 }





-- 
pozsy
