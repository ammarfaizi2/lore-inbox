Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWHaJwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWHaJwN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 05:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWHaJwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 05:52:12 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:28640 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750733AbWHaJwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 05:52:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IhtcZkHI4aNmT4MZMoodI94FAXO5+yvjUtxG2jrTQNvoV5Zbi2TSUQI53Czwagg9lF+1SaIbmGUGApVRSl75KnvGgTJErrKHRwmfRi7ZuU8tRKhxsuAMj80O5in0fXDreiUq8d9bNuZwLYZ5ItI80MDWCk3bHB+RVq84sbn+vm8=
Message-ID: <9a8748490608310252t1777d08ald96dcb1dd140a1e6@mail.gmail.com>
Date: Thu, 31 Aug 2006 11:52:11 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Rolf Eike Beer" <eike-kernel@sf-tec.de>
Subject: Re: 2.6.18-rc5-git3 build error on i386 - include/asm/spinlock.h
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Benjamin LaHaise" <bcrl@kvack.org>,
       "Linus Torvalds" <torvalds@osdl.org>, "Andi Kleen" <ak@suse.de>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <200608311143.43837.eike-kernel@sf-tec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490608310115o288fe080pdac53e8d2b8d3f84@mail.gmail.com>
	 <200608311143.43837.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/06, Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> Jesper Juhl wrote:
> > 2.6.18-rc5-git2 builds just fine, but with -git3 I get the following :
> >
> >   CHK     include/linux/version.h
> >   CHK     include/linux/utsrelease.h
> >   CC      arch/i386/kernel/asm-offsets.s
> > In file included from include/linux/spinlock.h:86,
> >                  from include/linux/capability.h:45,
> >                  from include/linux/sched.h:44,
> >                  from include/linux/module.h:9,
> >                  from include/linux/crypto.h:20,
> >                  from arch/i386/kernel/asm-offsets.c:7:
> > include/asm/spinlock.h: In function `__raw_read_lock':
> > include/asm/spinlock.h:164: error: syntax error before ')' token
> > include/asm/spinlock.h: In function `__raw_write_lock':
> > include/asm/spinlock.h:169: error: called object is not a function
> > include/asm/spinlock.h:169: warning: left-hand operand of comma
> > expression has no effect
> > include/asm/spinlock.h:169: warning: left-hand operand of comma
> > expression has no effect
> > include/asm/spinlock.h:169: error: syntax error before ')' token
> > make[1]: *** [arch/i386/kernel/asm-offsets.s] Error 1
> > make: *** [prepare0] Error 2
> >
> > Let me know if there's any additional info you need or patches you
> > want me to test.
>
> revert commit 8c74932779fc6f61b4c30145863a17125c1a296c
>
> Author: Andi Kleen <ak@suse.de> Wed, 30 Aug 2006 19:37:14 +0200
>
>     [PATCH] i386: Remove alternative_smp
>

Thanks.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
