Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263180AbTDYOEm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 10:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263197AbTDYOEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 10:04:42 -0400
Received: from main.gmane.org ([80.91.224.249]:13784 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263180AbTDYOEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 10:04:41 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Metzler <lkml-2003-03@downhill.at.eu.org>
Subject: Re: Linux 2.4.21-rc1
Date: Fri, 25 Apr 2003 14:15:48 +0000 (UTC)
Message-ID: <b8bfuk$g1$1@main.gmane.org>
References: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>
X-Complaints-To: usenet@main.gmane.org
X-Archive: encrypt
User-Agent: tin/1.5.18-20030412 ("Peephole") (UNIX) (Linux/2.4.21-pre4 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
> Here goes the first candidate for 2.4.21.
 
> Please test it extensively.

I'd love to, but the problem reported in 

Subject: [2.4.21-pre5] compile error in ip_conntrack_ftp.c:440:
Date: Wed, 5 Mar 2003 12:56:37 +0000 (UTC)
Message-ID: <b44s65$pdl$1@main.gmane.org>
http://www.ussg.iu.edu/hypermail/linux/kernel/0303.0/1008.html

still applies - I cannot compile the kernel.

Fetch either
http://www.logic.univie.ac.at/~ametzler/2.4.20.breaks.config
or use the example in the original mail as .config (after make mrproper),
run "make dep clean"  followed by "make modules" and get this:
____________________________________________________________
gcc -D__KERNEL__ -I/tmp/kerneltest/linux-2.4.20/include -Wall -Wstrict-prototype
s -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /tmp/k
erneltest/linux-2.4.20/include/linux/modversions.h  -nostdinc -iwithprefix inclu
de -DKBUILD_BASENAME=ip_conntrack_ftp  -c -o ip_conntrack_ftp.o ip_conntrack_ftp
.c
ip_conntrack_ftp.c:440: parse error before `this_object_must_be_defined_as_expor
t_objs_in_the_Makefile'
ip_conntrack_ftp.c:440: warning: type defaults to `int' in declaration of `this_
object_must_be_defined_as_export_objs_in_the_Makefile'
ip_conntrack_ftp.c:440: warning: data definition has no type or storage class
____________________________________________________________

                  cu andreas

