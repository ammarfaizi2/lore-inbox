Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291499AbSBACxc>; Thu, 31 Jan 2002 21:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291500AbSBACxW>; Thu, 31 Jan 2002 21:53:22 -0500
Received: from ns.suse.de ([213.95.15.193]:2821 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S291499AbSBACxJ>;
	Thu, 31 Jan 2002 21:53:09 -0500
Date: Fri, 1 Feb 2002 03:53:08 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: A Guy Called Tyketto <tyketto@wizard.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-dj1
In-Reply-To: <20020201024904.GA21231@wizard.com>
Message-ID: <Pine.LNX.4.33.0202010351250.14594-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002, A Guy Called Tyketto wrote:

> make[2]: Entering directory `/usr/src/linux/fs'
> make[2]: Circular /usr/src/linux/include/linux/qnx4_fs.h <-
> /usr/src/linux/include/linux/fs.h dependency dropped.

That I hadn't spotted, which needs fixing up later...

> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
> -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4
> -DKBUILD_BASENAME=filesystems  -DEXPORT_SYMTAB -c filesystems.c
> filesystems.c:20: parse error before `sys_nfsservctl'
> filesystems.c:21: warning: return-type defaults to `int'

fs/filesystems.c needs a #include <linux/linkage.h> added to it.

Thanks for the report.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

