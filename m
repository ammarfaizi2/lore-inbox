Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316364AbSFJVnV>; Mon, 10 Jun 2002 17:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316372AbSFJVnU>; Mon, 10 Jun 2002 17:43:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24847 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316364AbSFJVnT>;
	Mon, 10 Jun 2002 17:43:19 -0400
Message-ID: <3D051CC2.1030301@mandrakesoft.com>
Date: Mon, 10 Jun 2002 17:40:18 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ANN: Linux 2.2 driver compatibility toolkit
Content-Type: multipart/mixed;
 boundary="------------040305050700050907000705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040305050700050907000705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Don't load your drivers up with 2.2.x compatibility junk.  Write a 2.4.x 
driver... and use this toolkit to make it work under 2.2.

kcompat24 1.0.0 is now available for download at
http://prdownloads.sourceforge.net/gkernel/kcompat24-1.0.0.tar.gz?download

README attached.

--------------040305050700050907000705
Content-Type: text/plain;
 name="README.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="README.txt"


			kcompat24 toolkit version 1.0.0

This toolkit is designed to enable vendors and other Linux device
driver programmers to target their device drivers at the Linux 2.4.x
driver API, while still supporting the older Linux 2.2.x kernels.

This toolkit may be used in two ways:
1) Compile kcompat24.[ch] as a separate kernel module.  #include
kcompat24.h in your code.  Use this when building more than one 2.4.x
driver in a 2.2.x kernel.

2) Define the cpp symbol KCOMPAT_INCLUDED in your source code, and
#include kcompat24.c in your code.  All code, including kcompat24 code,
is compiled into a single ".o" kernel module.

The target audience is programmers, as there is practically no
documentation for this package.  The intention of kcompat24 is to
be a drop-in compatibility module that requires no code changes to a
standard Linux 2.4.x driver.  (note: that is the goal.  some changes
in 2.4.x APIs occasionally require compatibility macros added to the
driver source)

Note, this code has been developed and tested mainly with PCI network
drivers.  Thus, the PCI and network APIs are best represented.
It may require some additions in order to get other kernel driver
APIs to work seamlessly.

If you modify this code, please send additions back to the author
(in "diff -u" patch form) so that they may be incorporated in the
next release.

Credits:
	Jes Sorensen -- bug fixes, update to more recent kernel APIs
		(work sponsored by ServGate)
	Ted T'so -- much compatibility code from serial.c
	Donald Becker -- a little bit of compat code, I think
	Jeff Garzik <jgarzik@mandrakesoft.com>, Maintainer


--------------040305050700050907000705--

