Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbUCOShV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 13:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbUCOShV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 13:37:21 -0500
Received: from alpha.zarz.agh.edu.pl ([149.156.122.231]:60172 "EHLO
	alpha.zarz.agh.edu.pl") by vger.kernel.org with ESMTP
	id S262642AbUCOShA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 13:37:00 -0500
Date: Mon, 15 Mar 2004 19:41:57 +0100 (CET)
From: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: torvalds@osdl.org, davem@redhat.com
Subject: Re: [SPARC64][PPC] strange error ..
In-Reply-To: <Pine.LNX.4.58L.0403151437360.16193@alpha.zarz.agh.edu.pl>
Message-ID: <Pine.LNX.4.58L.0403151939460.17732@alpha.zarz.agh.edu.pl>
References: <Pine.LNX.4.58L.0403151437360.16193@alpha.zarz.agh.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK. here is trivial fix:

--- linux-2.6.4/init/do_mounts_initrd.c.org	2004-03-15 09:24:58.000000000 +0100
+++ linux-2.6.4/init/do_mounts_initrd.c	2004-03-15 19:35:50.186528400 +0100
@@ -1,6 +1,6 @@
 #define __KERNEL_SYSCALLS__
-#include <linux/unistd.h>
 #include <linux/kernel.h>
+#include <linux/unistd.h>
 #include <linux/fs.h>
 #include <linux/minix_fs.h>
 #include <linux/ext2_fs.h>

-- 
{Wojciech 'Sas' Cieciwa}  {Member of PLD Team                               }
{e-mail: cieciwa@alpha.zarz.agh.edu.pl, http://www2.zarz.agh.edu.pl/~cieciwa}
