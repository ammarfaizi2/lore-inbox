Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270090AbTGPC5C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 22:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270092AbTGPC5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 22:57:02 -0400
Received: from adsl-216-103-111-100.dsl.snfc21.pacbell.net ([216.103.111.100]:7860
	"EHLO www.piet.net") by vger.kernel.org with ESMTP id S270090AbTGPC47 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 22:56:59 -0400
Subject: Re: modules problems with 2.6.0 (module-init-tools-0.9.12)
From: Piet Delaney <piet@www.piet.net>
To: Diego Calleja =?ISO-8859-1?Q?Garc=EDa?= <diegocg@teleline.es>
Cc: rddunlap@osdl.org, fsanchez@mail.usfq.edu.ec, linux-kernel@vger.kernel.org,
       piet <piet@www.piet.net>
In-Reply-To: <20030716021210.56ea8360.diegocg@teleline.es>
References: <3F147B8F.5000103@mail.usfq.edu.ec>
	<20030715152257.614d628b.rddunlap@osdl.org>
	<1058313192.21300.988.camel@www.piet.net> 
	<20030716021210.56ea8360.diegocg@teleline.es>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 15 Jul 2003 20:11:33 -0700
Message-Id: <1058325093.18801.1224.camel@www.piet.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-15 at 17:12, Diego Calleja García wrote:
> El 15 Jul 2003 16:53:12 -0700 Piet Delaney <piet@www.piet.net> escribió:
> 
> > On Tue, 2003-07-15 at 15:22, Randy.Dunlap wrote:
> > 
> > I heard that if you install the new module-init-tools package in
> > /sbin that you would be able to boot old kernels. Is that true?
> 
> It works here.
> i've a debian distro, i apt-get'ed module-init-tools. Man modprobe says:
> 
> BACKWARDS COMPATIBILITY
>        This version of insmod is  for  kernels  2.5.48  and  above.   If  it
>        detects  a kernel with support for old-style modules (for which much of
>        the work was done in userspace), it will attempt to run  insmod.modu-
>        tils in its place, so it is completely transparent to the user.
> 
> diego@estel:~$ ls -l /sbin/insmod*
> -rwxr-xr-x    1 root     root         5072 2003-06-15 12:27 /sbin/insmod
> -rwxr-xr-x    1 root     root          359 2003-03-06 15:50 /sbin/insmod_ksymoops_clean
> -rwxr-xr-x    1 root     root        95372 2003-03-06 15:50 /sbin/insmod.modutils

Funny, I don't see insmod.modutils installed in /usr/local/sbin:

  	ls -l /usr/local/sbin/insmod*
	-rwxr-xr-x    1 root     root        28834 Jul  9 14:36
								/usr/local/sbin/insmod
	-rwxr-xr-x    1 root     root       461564 Jul  9 14:36
								/usr/local/sbin/insmod.static

I also didn't find insmod.modutils in the module-init-tools-0.9.12 src:
   [root@www src]# find module-init-tools-0.9.12 -name "*insmod*" -print
   module-init-tools-0.9.12/doc/insmod.sgml
   module-init-tools-0.9.12/insmod.c
   module-init-tools-0.9.12/insmod.8
   module-init-tools-0.9.12/.deps/insmod.Po
   module-init-tools-0.9.12/insmod.o
   module-init-tools-0.9.12/insmod
   module-init-tools-0.9.12/insmod.static
   [root@www src]#

> 
> 
> Looking at the size, insmod.modutils seems the 2.4 insmod loader. 
I think I missed something.


 
-- 
piet@www.piet.net

