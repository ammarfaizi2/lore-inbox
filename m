Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267259AbUIXEel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267259AbUIXEel (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 00:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUIXEel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 00:34:41 -0400
Received: from holomorphy.com ([207.189.100.168]:57052 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267259AbUIXEej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 00:34:39 -0400
Date: Thu, 23 Sep 2004 21:34:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ray Bryant <raybry@sgi.com>, alexn@telia.com, linux-kernel@vger.kernel.org
Subject: Re: lockmeter in 2.6.9-rc2-mm2
Message-ID: <20040924043432.GV9106@holomorphy.com>
References: <41539FC1.7040001@sgi.com> <20040923212106.7a89b3af.akpm@osdl.org> <20040924042807.GU9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924042807.GU9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Bryant <raybry@sgi.com> wrote:
>>> Does the x86_64 stuff compile now?

On Thu, Sep 23, 2004 at 09:21:06PM -0700, Andrew Morton wrote:
>> yup.  I do regular x86 and x86_64 allfooconfig builds.  I'd do so on
>> sparc64/ppc64/ia64 too, if they had a chance of compiling :(

On Thu, Sep 23, 2004 at 09:28:07PM -0700, William Lee Irwin III wrote:
> All it takes is grunt work to fix these; so how badly do you want them
> fixed?

FWIW, AFAICT x86-64 doesn't build with allyesconfig either. I use the
following to carry out allyesconfig compiletests.

Index: mm2-2.6.9-rc2/arch/x86_64/boot/tools/build.c
===================================================================
--- mm2-2.6.9-rc2.orig/arch/x86_64/boot/tools/build.c	2004-09-12 22:33:54.000000000 -0700
+++ mm2-2.6.9-rc2/arch/x86_64/boot/tools/build.c	2004-09-23 09:34:48.177166616 -0700
@@ -151,9 +151,6 @@
 	fprintf (stderr, "System is %d kB\n", sz/1024);
 	sys_size = (sz + 15) / 16;
 	/* 0x40000*16 = 4.0 MB, reasonable estimate for the current maximum */
-	if (sys_size > (is_big_kernel ? 0x40000 : DEF_SYSSIZE))
-		die("System is too big. Try using %smodules.",
-			is_big_kernel ? "" : "bzImage or ");
 	while (sz > 0) {
 		int l, n;
 
