Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129802AbQKTSg6>; Mon, 20 Nov 2000 13:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129234AbQKTSgt>; Mon, 20 Nov 2000 13:36:49 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:16902 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129411AbQKTSgm>;
	Mon, 20 Nov 2000 13:36:42 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Zdenek Kabelac <kabi@fi.muni.cz>
Date: Mon, 20 Nov 2000 19:06:07 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Bug in large files ext2 in 2.4.0-test11 ?
CC: linux-kernel@vger.kernel.org, bcollins@debian.org
X-mailer: Pegasus Mail v3.40
Message-ID: <D697E1046DD@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Nov 00 at 17:56, Zdenek Kabelac wrote:
> I just noticed this problem - 
> I'm missing some large files created in the filesystem.
> 
> This is 'ls' output from 2.4.0-test11/test10
> total 33
> drwxr-xr-x    6 root     root         4096 Nov 20 18:06 .
> drwxr-xr-x   42 root     root         1024 Nov 20 14:02 ..
> drwxr-xr-x    2 root     root         4096 Nov 19 15:50 X
> drwxr-xr-x    2 root     root        16384 Sep 30 18:45 lost+found
> ls: zero: Value too large for defined data type
> 
> but maybe its incompatibility in libc - anyway I'm using
> uptodate Debian Woody if this helps.

It is problem with Debian's glibc, it is compiled with 2.2.x kernel
headers. I filled bugreport against this few weeks ago, but it was marked
as inappropriate because of Debian glibc is built against newest
kernel-headers package, and newest kernel-headers package is still 2.2.x.

Maybe someone (you) should fill bug against kernel-headers or kernel-source
to get 2.4.x into Debian. Then Ben Collins (Debian glibc maintainer) can 
recompile and officially release glibc compiled against 2.4.x kernel.
                                                Best regards,
                                                        Petr Vandrovec
                                                        vandrove@vc.cvut.cz
                                                        
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
