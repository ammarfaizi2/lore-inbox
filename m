Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267009AbRGILQe>; Mon, 9 Jul 2001 07:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267010AbRGILQZ>; Mon, 9 Jul 2001 07:16:25 -0400
Received: from finch-post-11.mail.demon.net ([194.217.242.39]:26887 "EHLO
	finch-post-11.mail.demon.net") by vger.kernel.org with ESMTP
	id <S267009AbRGILQL>; Mon, 9 Jul 2001 07:16:11 -0400
Date: Mon, 9 Jul 2001 12:16:04 +0100
From: "Robert J.Dunlop" <rjd@xyzzy.clara.co.uk>
To: Stelian Pop <stelian.pop@fr.alcove.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.4.6-ac2] dmi_scan.c cleanups.
Message-ID: <20010709121604.A14967@xyzzy.clara.co.uk>
In-Reply-To: <20010709120814.D4850@come.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010709120814.D4850@come.alcove-fr>; from stelian.pop@fr.alcove.com on Mon, Jul 09, 2001 at 11:27:12AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2001 at 11:27:12AM +0100, Stelian Pop wrote:
> This patch cleans up the printk code in dmi_scan.c (the previous
> code gave compile warnings on enabling the printk).

A much smaller (but not necessarily better) patch would simply be:


--- arch/i386/kernel/dmi_scan.c.orig	Mon Jul  9 11:41:21 2001
+++ arch/i386/kernel/dmi_scan.c	Mon Jul  9 11:57:43 2001
@@ -15,7 +15,7 @@
 };
 
 #define dmi_printk(x)
-//#define dmi_printk(x) printk(x)
+//#define dmi_printk(x) printk x
 
 static char * __init dmi_string(struct dmi_header *dm, u8 s)
 {


-- 
        Bob Dunlop
        rjd@xyzzy.clara.co.uk
        www.xyzzy.clara.co.uk
