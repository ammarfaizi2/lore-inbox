Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbWHaJnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWHaJnx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 05:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWHaJnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 05:43:53 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:23472 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751050AbWHaJnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 05:43:53 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: 2.6.18-rc5-git3 build error on i386 - include/asm/spinlock.h
Date: Thu, 31 Aug 2006 11:43:38 +0200
User-Agent: KMail/1.9.4
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Benjamin LaHaise" <bcrl@kvack.org>,
       "Linus Torvalds" <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
References: <9a8748490608310115o288fe080pdac53e8d2b8d3f84@mail.gmail.com>
In-Reply-To: <9a8748490608310115o288fe080pdac53e8d2b8d3f84@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1537574.1zB6vWqRiN";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200608311143.43837.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1537574.1zB6vWqRiN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Jesper Juhl wrote:
> 2.6.18-rc5-git2 builds just fine, but with -git3 I get the following :
>
>   CHK     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   CC      arch/i386/kernel/asm-offsets.s
> In file included from include/linux/spinlock.h:86,
>                  from include/linux/capability.h:45,
>                  from include/linux/sched.h:44,
>                  from include/linux/module.h:9,
>                  from include/linux/crypto.h:20,
>                  from arch/i386/kernel/asm-offsets.c:7:
> include/asm/spinlock.h: In function `__raw_read_lock':
> include/asm/spinlock.h:164: error: syntax error before ')' token
> include/asm/spinlock.h: In function `__raw_write_lock':
> include/asm/spinlock.h:169: error: called object is not a function
> include/asm/spinlock.h:169: warning: left-hand operand of comma
> expression has no effect
> include/asm/spinlock.h:169: warning: left-hand operand of comma
> expression has no effect
> include/asm/spinlock.h:169: error: syntax error before ')' token
> make[1]: *** [arch/i386/kernel/asm-offsets.s] Error 1
> make: *** [prepare0] Error 2
>
> Let me know if there's any additional info you need or patches you
> want me to test.

revert commit 8c74932779fc6f61b4c30145863a17125c1a296c

Author: Andi Kleen <ak@suse.de> Wed, 30 Aug 2006 19:37:14 +0200

    [PATCH] i386: Remove alternative_smp

Eike

--nextPart1537574.1zB6vWqRiN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBE9q9PXKSJPmm5/E4RAkcpAJ9Njjyh/5+BY/TI8Z0YRMLKEEcV+ACglHvi
mX0l8Ew/a+k5KI6NNgards0=
=3BNq
-----END PGP SIGNATURE-----

--nextPart1537574.1zB6vWqRiN--
