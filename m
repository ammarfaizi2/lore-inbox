Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293194AbSB1X0z>; Thu, 28 Feb 2002 18:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310185AbSB1XYo>; Thu, 28 Feb 2002 18:24:44 -0500
Received: from CPE-203-51-26-71.nsw.bigpond.net.au ([203.51.26.71]:36853 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S310198AbSB1XTN>; Thu, 28 Feb 2002 18:19:13 -0500
Message-ID: <3C7EBAEC.B274829C@eyal.emu.id.au>
Date: Fri, 01 Mar 2002 10:19:08 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre2
In-Reply-To: <Pine.LNX.4.21.0202281742250.2182-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> Here is 2.4.19-pre2: A very big patch (around 13MB uncompressed) due to

Practically everything module is built.

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h 
-DKBUILD_BASENAME=cciss  -c -o cciss.o cciss.c
cciss.c: In function `cciss_remove_one':
cciss.c:2129: too few arguments to function `sendcmd'
make[2]: *** [cciss.o] Error 1
make[2]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre/drivers/block'

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
