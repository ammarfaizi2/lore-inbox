Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751499AbWFULHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbWFULHm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 07:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWFULHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 07:07:42 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:10741 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751499AbWFULHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 07:07:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y7Wqv1Oawio2NkLTlTOuhu0sudL9W8Bk7x+wIlEZBYtldJtWqbWBqmuvfhxuI8O0xwc6kCxnx6qVKvpoAsOM/1R31h3grHp4/DBl7w+JOg1o0+LgelJR1Oi5VEDxk4/TZ7NevK3MUfWZP8U9NGINodMDBobEBdX2VJLTj4NGFwU=
Message-ID: <6bffcb0e0606210407y781b3d41nef533847f579520b@mail.gmail.com>
Date: Wed, 21 Jun 2006 13:07:41 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-mm1
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060621034857.35cfe36f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21/06/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm1/
>
>
> - powerpc is bust (on g5, at least).  git-klibc is causing nash to fail on
>   startup and some later patch is causing a big crash (I didn't bisect that
>   one - later).
>
> - ia64 doesn't compile for me, due to git-klibc problems (a truly ancient
>   toolchain might be implicated).
>

I have the similar problem here

usr/klibc/syscalls/typesize.c:1:23: error: syscommon.h: No such file
or directory
usr/klibc/syscalls/typesize.c:5: error: '__u32' undeclared here (not
in a function)
usr/klibc/syscalls/typesize.c:9: error: expected ')' before 'gid_t'
usr/klibc/syscalls/typesize.c:9: warning: type defaults to 'int' in
declaration of 'type name'
usr/klibc/syscalls/typesize.c:10: error: expected ')' before 'sigset_t'
usr/klibc/syscalls/typesize.c:10: warning: type defaults to 'int' in
declaration of 'type name'
usr/klibc/syscalls/typesize.c:21: error: 'dev_t' undeclared here (not
in a function)
usr/klibc/syscalls/typesize.c:22: error: 'fd_set' undeclared here (not
in a function)
usr/klibc/syscalls/typesize.c:22: error: expected expression before ')' token
make[4]: *** [usr/klibc/syscalls/typesize.o] Error 1
make[3]: *** [usr/klibc/syscalls] Error 2
make[2]: *** [_usr_klibc] Error 2
make[1]: *** [usr] Error 2
make: *** [_all] Error 2

Linux ltg01-fedora.pl 2.6.17-g25f42b6a #63 SMP PREEMPT Tue Jun 20
14:28:14 CEST 2006 i686 i686 i386 GNU/Linux

Gnu C                  4.1.1
Gnu make               3.80
binutils               2.16.91.0.6
util-linux             2.13-pre7
mount                  2.13-pre7
module-init-tools      3.2.2
e2fsprogs              1.38
jfsutils               1.1.10
reiserfsprogs          3.6.19
xfsprogs               2.7.3
PPP                    2.4.3
Linux C Library        > libc.2.4
Dynamic linker (ldd)   2.4
Procps                 3.2.6
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.96
udev                   084

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
