Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314090AbSDQOYJ>; Wed, 17 Apr 2002 10:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314092AbSDQOYI>; Wed, 17 Apr 2002 10:24:08 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2180 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S314090AbSDQOYH>; Wed, 17 Apr 2002 10:24:07 -0400
Date: Wed, 17 Apr 2002 10:26:03 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andrey Ulanov <drey@rt.mipt.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: FPU, i386
In-Reply-To: <20020417140510.GB9930@gleam.rt.mipt.ru>
Message-ID: <Pine.LNX.3.95.1020417101313.24212A-200000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-1755858991-1019053563=:24212"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1678434306-1755858991-1019053563=:24212
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 17 Apr 2002, Andrey Ulanov wrote:

> Look at this:
> 
> $ cat test.c
> #include <stdio.h>
> 
> main()
> {
> 	double h = 0.2;
> 	
> 	if(1/h == 5.0)
> 	    printf("1/h == 5.0\n");
> 
> 	if(1/h < 5.0)
> 	    printf("1/h < 5.0\n");
> 	return 0;
> }
> $ gcc test.c
> $ ./a.out
> 1/h < 5.0
> $ 
> 
> I also ran same a.out under FreeBSD. It says "1/h == 5.0".
> It seems there is difference somewhere in FPU 
> initialization code. And I think it should be fixed.
> 

No. No. No. Read something about basic programming of floating-point
operations before complaining about something you obviously know
nothing about. "==" has no use in floating-point operations. Any
code that uses "==", referencing floating-point numbers is broken.

If the BSD 'C' runtime library fortuously says that 1.0/0.2 == 5, than
you just got lucky. Time to play the lottery. FYI, you can set the
per-process FPU initialization anyway you want. FYI, by default it
ignores 1/0 errors:


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

--1678434306-1755858991-1019053563=:24212
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="fpu.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.95.1020417102603.24212B@chaos.analogic.com>
Content-Description: 

LyoNCiAqICBOb3RlIEZQVSBjb250cm9sIG9ubHkgZXhpc3RzIHBlciBwcm9j
ZXNzLiBUaGVyZWZvcmUsIHlvdSBoYXZlDQogKiAgdG8gc2V0IHVwIHRoZSBG
UFUgYmVmb3JlIHlvdSB1c2UgaXQgaW4gYW55IHByb2dyYW0uDQogKi8NCiNp
bmNsdWRlIDxpMzg2L2ZwdV9jb250cm9sLmg+DQoNCiNkZWZpbmUgRlBVX01B
U0sgKF9GUFVfTUFTS19JTSB8XA0KICAgICAgICAgICAgICAgICAgX0ZQVV9N
QVNLX0RNIHxcDQogICAgICAgICAgICAgICAgICBfRlBVX01BU0tfWk0gfFwN
CiAgICAgICAgICAgICAgICAgIF9GUFVfTUFTS19PTSB8XA0KICAgICAgICAg
ICAgICAgICAgX0ZQVV9NQVNLX1VNIHxcDQogICAgICAgICAgICAgICAgICBf
RlBVX01BU0tfUE0pDQoNCnZvaWQgZnB1KCkNCnsNCiAgICBfX3NldGZwdWN3
KF9GUFVfREVGQVVMVCAmIH5GUFVfTUFTSyk7DQp9DQoNCg0KbWFpbigpIHsN
CiAgIGRvdWJsZSB6ZXJvPTAuMDsNCiAgIGRvdWJsZSBvbmU9MS4wOw0KICAg
ZnB1KCk7DQoNCiAgIG9uZSAvPXplcm87DQp9DQoNCg==
--1678434306-1755858991-1019053563=:24212--
