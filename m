Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292508AbSBTVG6>; Wed, 20 Feb 2002 16:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292513AbSBTVGt>; Wed, 20 Feb 2002 16:06:49 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:13832 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S292508AbSBTVGf>; Wed, 20 Feb 2002 16:06:35 -0500
Subject: Re: 2.5.5 -- filesystems.c:30: In function `sys_nfsservctl':
	dereferencing pointer to incomplete type
From: Miles Lane <miles@megapathdsl.net>
To: Robert Love <rml@tech9.net>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1014238274.18361.62.camel@phantasy>
In-Reply-To: <1014228802.6910.29.camel@turbulence.megapathdsl.net> 
	<15476.1699.209321.808094@notabene.cse.unsw.edu.au> 
	<1014238274.18361.62.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 20 Feb 2002 13:02:38 -0800
Message-Id: <1014238958.1726.38.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-02-20 at 12:51, Robert Love wrote:
> On Wed, 2002-02-20 at 15:27, Neil Brown wrote:
> 
> > Opps, my mistake.
> > 
> > Please try this.
> 
> This does not apply to my include/linux/nfsd/interface.h ?
> 
> In 2.5.5, that file is 24 lines long.  The first hunk applies, but the
> second, at line 155, obviously does not.

FWIW, when I compiled using Steven Cole's patch, it compiles.
I haven't run the kernel yet, though.

--- linux-2.5.5/fs/filesystems.c.orig   Wed Feb 20 07:52:36 2002
+++ linux-2.5.5/fs/filesystems.c        Wed Feb 20 12:35:42 2002
@@ -22,7 +22,7 @@
 {
        int ret = -ENOSYS;
        
-#if defined(CONFIG_MODULES)
+#if defined(CONFIG_NFSD_MODULE)
        lock_kernel();
 
        if (nfsd_linkage ||



