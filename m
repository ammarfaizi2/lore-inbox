Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292986AbSCJAEN>; Sat, 9 Mar 2002 19:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292987AbSCJAEE>; Sat, 9 Mar 2002 19:04:04 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:24096 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S292986AbSCJADu>; Sat, 9 Mar 2002 19:03:50 -0500
Message-ID: <3C8AA2D7.5953DA31@ngforever.de>
Date: Sat, 09 Mar 2002 17:03:35 -0700
From: Thunder from the hill <thunder@ngforever.de>
Organization: The LuckyNet Administration
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.8-26mdk i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Seiichi Nakashima <nakasima@kumin.ne.jp>
CC: linux-kernel@vger.kernel.org, nakasei@fa.mdis.co.jp
Subject: Re: 2.2.21-pre4 hung up
In-Reply-To: <200203092312.AA00022@prism.kumin.ne.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> I update to linux-2.2.20 + patch-2.2.21-pre4.
> before I used linux-2.2.20 + patch-2.2.21-pre3, and worked fine.
> linux-2.2.21-pre4 is normal end to patch, compile and install, but bootup failuer.
> 
> these messages displayed on console, and hung up.
> ...

ok, just to forward the patches:
>diff -ruN linux-2.2.21-pre3/arch/i386/kernel/bluesmoke.c linux-2.2.21-pre4/arch/i386/kernel/bluesmoke.c
>--- linux-2.2.21-pre3/arch/i386/kernel/bluesmoke.c	Sun Mar  3 23:20:11 2002
>+++ linux-2.2.21-pre4/arch/i386/kernel/bluesmoke.c	Sat Mar  9 03:58:57 2002
>@@ -165,7 +164,7 @@
> if(l&(1<<8))
> wrmsr(0x17b, 0xffffffff, 0xffffffff);
> banks = l&0xff;
>-	for(i=1;i<banks;i++)
>+	for(i=0;i<banks;i++)
> {
> wrmsr(0x400+4*i, 0xffffffff, 0xffffffff); 
> }
>
> Same here. s/i=0/i=1/ i the for() and my PII boots again.

Thunder
-- 
begin-base64 755 -
IyEgL3Vzci9iaW4vcGVybApteSAgICAgJHNheWluZyA9CSMgVGhlIHNjcmlw
dCBvbiB0aGUgbGVmdCBpcyB0aGUgcHJvb2YKIk5lbmEgaXN0IGVpbiIgLgkj
IHRoYXQgaXQgaXNuJ3QgYWxsIHRoZSB3YXkgaXQgc2VlbXMKIiB2ZXJhbHRl
dGVyICIgLgkjIHRvIGJlIChlc3BlY2lhbGx5IG5vdCB3aXRoIG1lKQoiTkRX
LVN0YXIuXG4iICA7CiRzYXlpbmcgPX4Kcy9ORFctU3Rhci9rYW5uXAogdW5z
IHJldHRlbi9nICA7CiRzYXlpbmcgICAgICAgPX4Kcy92ZXJhbHRldGVyL2Rp
XAplIExpZWJlL2c7CiRzYXlpbmcgPX5zL2Vpbi8KbnVyL2c7JHNheWluZyA9
fgpzL2lzdC9zYWd0LC9nICA7CiRzYXlpbmc9fnMvXG4vL2cKO3ByaW50Zigk
c2F5aW5nKQo7cHJpbnRmKCJcbiIpOwo=
====
Extract this and see what will happen if you execute my
signature. Just save it to file and do a
> uudecode $file | perl
