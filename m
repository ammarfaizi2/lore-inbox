Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129478AbRCYLhq>; Sun, 25 Mar 2001 06:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131271AbRCYLhg>; Sun, 25 Mar 2001 06:37:36 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:2826 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129478AbRCYLhS>;
	Sun, 25 Mar 2001 06:37:18 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: drew@drewb.com
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3-pre7 and System.map, bzImage ?? 
In-Reply-To: Your message of "Sun, 25 Mar 2001 11:14:44 GMT."
             <15037.54052.77265.743026@champ.serialhacker.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 25 Mar 2001 21:36:31 +1000
Message-ID: <4010.985520191@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Mar 2001 11:14:44 +0000 (), 
Drew Bertola <drew@drewb.com> wrote:
>I've compiled 2.4.3-pre7 and no errors were reported, yet I can't find
>the kernel bzImage or System.map file.  Did I miss a major change in the
>install procedure since 2.4.1?

The only change that might cause a problem is to arch/i386/boot/Makefile.

@@ -43,7 +43,7 @@ tools/build: tools/build.c
        $(HOSTCC) $(HOSTCFLAGS) -o $@ $< -I$(TOPDIR)/include
 
 bootsect: bootsect.o
-       $(LD) -Ttext 0x0 -s -oformat binary -o $@ $<
+       $(LD) -Ttext 0x0 -s --oformat binary -o $@ $<

There was also a bug fix to genksyms processing, although that is less
likely to be the cause.  Check that your modutils and binutils are up
to date.

