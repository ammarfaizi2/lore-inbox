Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129720AbQKTS5e>; Mon, 20 Nov 2000 13:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129521AbQKTS5Y>; Mon, 20 Nov 2000 13:57:24 -0500
Received: from ppp17.ts1-1.NewportNews.visi.net ([209.8.196.17]:39668 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S129585AbQKTS5O>; Mon, 20 Nov 2000 13:57:14 -0500
Date: Mon, 20 Nov 2000 13:19:50 -0500
From: Ben Collins <bcollins@debian.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Zdenek Kabelac <kabi@fi.muni.cz>, linux-kernel@vger.kernel.org
Subject: Re: Bug in large files ext2 in 2.4.0-test11 ?
Message-ID: <20001120131950.X619@visi.net>
In-Reply-To: <D697E1046DD@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <D697E1046DD@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Mon, Nov 20, 2000 at 07:06:07PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2000 at 07:06:07PM +0000, Petr Vandrovec wrote:
> On 20 Nov 00 at 17:56, Zdenek Kabelac wrote:
> > I just noticed this problem - 
> > I'm missing some large files created in the filesystem.
> > 
> > This is 'ls' output from 2.4.0-test11/test10
> > total 33
> > drwxr-xr-x    6 root     root         4096 Nov 20 18:06 .
> > drwxr-xr-x   42 root     root         1024 Nov 20 14:02 ..
> > drwxr-xr-x    2 root     root         4096 Nov 19 15:50 X
> > drwxr-xr-x    2 root     root        16384 Sep 30 18:45 lost+found
> > ls: zero: Value too large for defined data type
> > 
> > but maybe its incompatibility in libc - anyway I'm using
> > uptodate Debian Woody if this helps.
> 
> It is problem with Debian's glibc, it is compiled with 2.2.x kernel
> headers. I filled bugreport against this few weeks ago, but it was marked
> as inappropriate because of Debian glibc is built against newest
> kernel-headers package, and newest kernel-headers package is still 2.2.x.
> 
> Maybe someone (you) should fill bug against kernel-headers or kernel-source
> to get 2.4.x into Debian. Then Ben Collins (Debian glibc maintainer) can 
> recompile and officially release glibc compiled against 2.4.x kernel.
>                                                 Best regards,
>                                                         Petr Vandrovec
>                                                         vandrove@vc.cvut.cz

Does kernel 2.4.x compile and run well for all of our supported archs?
Do programs compiled against a glibc with LFS (2.4.x kernel) support, and
using that LFS support, work on kernel 2.2.x machines?

If the answer to the first one is "no", then the spread of LFS will be
slow in Debian, until 2.4.0 becomes stable enough to use. If the answer to
the second is "no", then you wont see LFS support in Debian till post
woody.

Secondly, anyone who thinks they know what they are doing, can simply
download the Debian glibc sources files, and build against kernel-2.4.0
headers with this simple command:

LINUX_SOURCE=/usr/src/linux-2.4.0-test11 apt-get -b source glibc

Simple, eh? :)

Ben

-- 
 -----------=======-=-======-=========-----------=====------------=-=------
/  Ben Collins  --  ...on that fantastic voyage...  --  Debian GNU/Linux   \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
