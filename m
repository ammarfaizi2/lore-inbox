Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314448AbSFEKQg>; Wed, 5 Jun 2002 06:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314553AbSFEKQf>; Wed, 5 Jun 2002 06:16:35 -0400
Received: from inet-mail2.oracle.com ([148.87.2.202]:8946 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S314448AbSFEKQd>; Wed, 5 Jun 2002 06:16:33 -0400
Message-ID: <3CFDE3F4.9090205@oracle.com>
Date: Wed, 05 Jun 2002 12:12:04 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020516
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.20-dj3
In-Reply-To: <20020604233824.GA24642@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> Patch queue under control again, this gets the interesting bits
> out of the way, and introduces some of the kbuild2.5 bits in a
> hope to cut down the number of "Will you merge kbuild2.5" mails
> I get each day.
> 

In the attempt to get my Xircom Cardbus PCI working (2.5.20
  plus GregKH extraction of Patrick's PCI detection patch is
  still not working for me) I decided to give -dj3 a spin...
  modular IrDA doesn't build (2.5.20 vanilla does):

make[3]: Entering directory `/usr/local/src/linux-2.5.20/drivers/net/irda'
gcc -D__KERNEL__ -I/usr/local/src/linux-2.5.20/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -DKBUILD_BASENAME=irtty  -c -o irtty.o irtty.c
In file included from /usr/local/src/linux-2.5.20/include/net/irda/timer.h:37,
                  from irtty.c:40:
/usr/local/src/linux-2.5.20/include/net/irda/irlmp.h:148: parse error before "CACHE_ENTRY"
/usr/local/src/linux-2.5.20/include/net/irda/irlmp.h:148: warning: no semicolon at end of struct or union
/usr/local/src/linux-2.5.20/include/net/irda/irlmp.h: In function `irlmp_lap_tx_queue_full':
/usr/local/src/linux-2.5.20/include/net/irda/irlmp.h:258: dereferencing pointer to incomplete type
/usr/local/src/linux-2.5.20/include/net/irda/irlmp.h:261: dereferencing pointer to incomplete type
irtty.c: In function `irtty_cleanup':
irtty.c:125: warning: concatenation of string literals with __FUNCTION__ is deprecated
irtty.c: In function `irtty_open':
irtty.c:232: warning: concatenation of string literals with __FUNCTION__ is deprecated
irtty.c:251: warning: concatenation of string literals with __FUNCTION__ is deprecated
irtty.c: In function `irtty_change_speed':
irtty.c:458: warning: concatenation of string literals with __FUNCTION__ is deprecated
irtty.c:469: warning: concatenation of string literals with __FUNCTION__ is deprecated
make[3]: *** [irtty.o] Error 1
make[3]: Leaving directory `/usr/local/src/linux-2.5.20/drivers/net/irda'
make[2]: *** [_modsubdir_irda] Error 2
make[2]: Leaving directory `/usr/local/src/linux-2.5.20/drivers/net'
make[1]: *** [_modsubdir_net] Error 2
make[1]: Leaving directory `/usr/local/src/linux-2.5.20/drivers'
make: *** [_mod_drivers] Error 2


Ciao,

--alessandro

  "the hands that build / can also pull down
    even the hands of love"
                             (U2, "Exit")

