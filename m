Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318102AbSGWPrr>; Tue, 23 Jul 2002 11:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318105AbSGWPrr>; Tue, 23 Jul 2002 11:47:47 -0400
Received: from mail.pixelwings.com ([194.152.163.212]:10513 "EHLO
	pixelwings.com") by vger.kernel.org with ESMTP id <S318102AbSGWPrp> convert rfc822-to-8bit;
	Tue, 23 Jul 2002 11:47:45 -0400
Date: Tue, 23 Jul 2002 17:50:51 +0200
From: Clemens Schwaighofer <cs@pixelwings.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.27-dj1
Message-ID: <1349532704.1027439451@[192.168.1.172]>
In-Reply-To: <20020722192054.O27749@suse.de>
References: <20020721215845.GA23019@suse.de>
 <1340522704.1027338950@[192.168.1.172]> <20020722192054.O27749@suse.de>
X-Mailer: Mulberry/2.2.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dave Jones

--On Monday, July 22, 2002 07:20:54 PM +0200 you wrote:

> On Mon, Jul 22, 2002 at 01:55:50PM +0200, Clemens Schwaighofer wrote:
>  > I just tried it on my test system (Redhat 7.3 with gcc-3.1-9 from
> rawhide)   > and I get this
>  > fs/fs.o(.text+0x27f66): undefined reference to `jiffies_64_to_clock_t'
>  > fs/fs.o(.text+0x297fb): undefined reference to `jiffies_64_to_clock_t'
>  > fs/fs.o(.text+0x29877): undefined reference to `jiffies_64_to_clock_t'
>
> See the post from Tim Schmielau in this thread, and apply the patch there.

thought that fixes this error, another one pops up (same config, same 
computer)

  gcc -Wp,-MD,./.dirhash.o.d -D__KERNEL__ 
-I/usr/src/kernel/2.5.27-dj1/linux-2.5.27/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
-pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix 
include -DMODULE -include 
/usr/src/kernel/2.5.27-dj1/linux-2.5.27/include/linux/modversions.h 
-DKBUILD_BASENAME=dirhash   -c -o dirhash.o dirhash.c
  gcc -Wp,-MD,./.init.o.d -D__KERNEL__ 
-I/usr/src/kernel/2.5.27-dj1/linux-2.5.27/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
-pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix 
include -DMODULE -include 
/usr/src/kernel/2.5.27-dj1/linux-2.5.27/include/linux/modversions.h 
-DKBUILD_BASENAME=init   -c -o init.o init.c
  gcc -Wp,-MD,./.inode.o.d -D__KERNEL__ 
-I/usr/src/kernel/2.5.27-dj1/linux-2.5.27/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
-pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix 
include -DMODULE -include 
/usr/src/kernel/2.5.27-dj1/linux-2.5.27/include/linux/modversions.h 
-DKBUILD_BASENAME=inode   -c -o inode.o inode.c
inode.c: In function `autofs_read_inode':
inode.c:213: `autofs_root_operations' undeclared (first use in this 
function)
inode.c:213: (Each undeclared identifier is reported only once
inode.c:213: for each function it appears in.)
make[3]: *** [inode.o] Error 1
make[3]: Leaving directory 
`/usr/src/kernel/2.5.27-dj1/linux-2.5.27/fs/autofs'
make[2]: *** [autofs] Error 2
make[2]: Leaving directory `/usr/src/kernel/2.5.27-dj1/linux-2.5.27/fs'
make[1]: *** [fs] Error 2
make[1]: Leaving directory `/usr/src/kernel/2.5.27-dj1/linux-2.5.27'
make: *** [modules] Error 2


-- 
"Der Krieg ist ein Massaker von Leuten, die sich nicht kennen, zum
Nutzen von Leuten, die sich kennen, aber nicht massakrieren"
- Paul Valéry (1871-1945)
mfg, Clemens Schwaighofer                       PIXELWINGS Medien GMBH
Kandlgasse 15/5, A-1070 Wien                      T: [+43 1] 524 58 50
JETZT NEU! MIT FEWA GEWASCHEN       -->      http://www.pixelwings.com
