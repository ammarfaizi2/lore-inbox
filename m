Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273533AbRIUQne>; Fri, 21 Sep 2001 12:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273529AbRIUQnW>; Fri, 21 Sep 2001 12:43:22 -0400
Received: from mpdr0.cleveland.oh.ameritech.net ([206.141.223.14]:22750 "EHLO
	mailhost.cle.ameritech.net") by vger.kernel.org with ESMTP
	id <S273525AbRIUQnC>; Fri, 21 Sep 2001 12:43:02 -0400
Date: Fri, 21 Sep 2001 12:43:21 -0400 (EDT)
From: Stephen Torri <storri@ameritech.net>
X-X-Sender: <torri@base.torri.linux>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Announce: ksymoops 2.4.3 is available
In-Reply-To: <10723.1001063398@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.33.0109211238010.1454-100000@base.torri.linux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recompiling ksymoops with gcc-3.0.2 produces the following errors:

(rpm --rebuild ksymoops-2.4.3-1.src.rpm):

ksymoops.c:114:1: directives may not be used inside a macro argument
ksymoops.c:114:1: unterminated argument list invoking macro "printf"
ksymoops.c: In function `usage':
ksymoops.c:117: parse error before string constant

gcc is using the flags "-march=i386 -mcpu=i686" when it tries to compile
ksymoops.c

(rpm -bb ksymoops.spec after installing):

Reports the same errors as above and uses the same -march and -mcpu flags.

(make within the ksymoops directory):

Compile completes successfully. Although the following warnings are
produce:

symbol.c:220:58: warning: trigraph ??> ignored
symbol.c:221:44: warning: trigraph ??> ignored
symbol.c:225:49: warning: trigraph ??> ignored
symbol.c:226:35: warning: trigraph ??> ignored

Stephen Torri

On Fri, 21 Sep 2001, Keith Owens wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Content-Type: text/plain; charset=us-ascii
>
> ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4
>
> ksymoops-2.4.3.tar.gz		Source tarball, includes RPM spec file
> ksymoops-2.4.3-1.src.rpm	As above, in SRPM format
> ksymoops-2.4.3-1.i386.rpm	Compiled with 2.96 20000731, glibc 2.2.2
> ksymoops-2.4.3-1.ia64.rpm	Compiled with gcc 2.96-ia64-20000731,
> 				glibc-2.2.3.
> patch-ksymoops-2.4.3.gz		Patch from ksymoops 2.4.2 to 2.4.3.
>
> No sparc binary, I do not have access to a sparc system with a decent
> version of binutils.
>
> Changelog extract
>
> 	* Add Pid:.
> 	* Add -A "address list".  Idea pinched from Randy Dunlap's ksysmap.
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.0.4 (GNU/Linux)
> Comment: Exmh version 2.1.1 10/15/1999
>
> iD8DBQE7qwPli4UHNye0ZOoRAqtjAJ9JKaMGxlU8Bwqwmn7ShJ9OhlctmgCg2rPQ
> M4jW+vdQfuMSFPPRleKTj5Y=
> =LC33
> -----END PGP SIGNATURE-----
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

