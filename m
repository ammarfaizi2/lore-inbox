Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262054AbTCRAWD>; Mon, 17 Mar 2003 19:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262055AbTCRAWD>; Mon, 17 Mar 2003 19:22:03 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:36106 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262054AbTCRAWC>;
	Mon, 17 Mar 2003 19:22:02 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Maxime <x@organigramme.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: make bzImage fails when LANG set 
In-reply-to: Your message of "Sun, 16 Mar 2003 11:53:48 CDT."
             <3E74AC1C.8010901@organigramme.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Date: Tue, 18 Mar 2003 11:32:41 +1100
Message-ID: <31970.1047947561@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Mar 2003 11:53:48 -0500, 
Maxime <x@organigramme.net> wrote:
>I'm on a lfs 4.0 system.  I installed the kernel witouth any problem. 
> But then I eventually needed to recompile, and it failed during the 
>make bzImage.  Outputing this :
>
>Dans le fichier inclus à partir de 
>/usr/src/linux-2.4.19/include/linux/wait.h:13,
>          à partir de /usr/src/linux-2.4.19/include/linux/fs.h:12,

Index: 19.1/Makefile
--- 19.1/Makefile Sat, 03 Aug 2002 11:13:10 +1000 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.25.2.2.1.17.1.4.1.29.1.40.1.30 644)
+++ 19.1(w)/Makefile Tue, 18 Mar 2003 11:31:05 +1100 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.25.2.2.1.17.1.4.1.29.1.40.1.30 644)
@@ -258,7 +258,7 @@ include arch/$(ARCH)/Makefile
 # 'kbuild_2_4_nostdinc :=' or -I/usr/include for kernel code and you are not UML
 # then your code is broken!  KAO.
 
-kbuild_2_4_nostdinc	:= -nostdinc $(shell $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')
+kbuild_2_4_nostdinc	:= -nostdinc $(shell LANG=C $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')
 export kbuild_2_4_nostdinc
 
 export	CPPFLAGS CFLAGS CFLAGS_KERNEL AFLAGS AFLAGS_KERNEL

