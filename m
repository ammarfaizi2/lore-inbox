Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314328AbSECPaB>; Fri, 3 May 2002 11:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314330AbSECPaA>; Fri, 3 May 2002 11:30:00 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:17677 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314328AbSECPaA>;
	Fri, 3 May 2002 11:30:00 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: tomas szepe <kala@pinerecords.com>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: your mail 
In-Reply-To: Your message of "Fri, 03 May 2002 16:37:38 +0200."
             <20020503143738.GC14121@louise.pinerecords.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 04 May 2002 01:29:46 +1000
Message-ID: <14454.1020439786@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 May 2002 16:37:38 +0200, 
tomas szepe <kala@pinerecords.com> wrote:
>kala@nibbler:~$ tar xzf /usr/src/linux-2.5.13.tgz 
>kala@nibbler:~$ cd linux-2.5.13 
>kala@nibbler:~/linux-2.5.13$ zcat /usr/src/kbuild-2.5-core-10.gz /usr/src/kbuild-2.5-common-2.5.13-1.gz /usr/src/kbuild-2.5-i386-2.5.13-1.gz |patch -sp1
>kala@nibbler:~/linux-2.5.13$ cp /lib/modules/2.5.13/.config .
>kala@nibbler:~/linux-2.5.13$ make -f Makefile-2.5 oldconfig
>Makefile-2.5:251: /no_such_file-arch/i386/Makefile.defs.noconfig: No such file or directory

The trailing '/' is omitted in one case.  Workaround for common source and object

export KBUILD_SRCTREE_000=`pwd`/
make -f Makefile-2.5 oldconfig

