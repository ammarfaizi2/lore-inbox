Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422722AbWJFWrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422722AbWJFWrE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 18:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbWJFWrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 18:47:04 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:30989 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932658AbWJFWrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 18:47:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n9rKprFqFdxec/9Pt8iaMcxct/gmVAU3+58CPl0tttRNtlTXEQxzCKdEafGgeoBMbVgz18O8GJXyZJDPAetTBVaI4xRb74zUPcBFXwb+UARYTZCZPTbxYNjDXXqNeAdy9lEqkT8QNSItN6KUT/cP0/zCp9MlKrdtEnmefgwwmTY=
Message-ID: <9a8748490610061547g6c62ee7dq37c139c1966ea8c5@mail.gmail.com>
Date: Sat, 7 Oct 2006 00:47:00 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Merge window closed: v2.6.19-rc1
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       James.Bottomley@HansenPartnership.com
In-Reply-To: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
> Ok, it's two weeks since v2.6.18, and as a result I've cut a -rc1 release.
>
> As usual for -rc1 with a lot of pending merges, it's a huge thing with
> tons of changes, and in fact since 2.6.18 took longer than normal due to
> me traveling (and others probably also being on vacations), it's possibly
> even larger than usual.
>
> I think we got updates to pretty much all of the active architectures,
> we've got VM changes (dirty shared page tracking, for example), we've got
> networking, drivers, you name it. Even the shortlog and the diffstats are
> too big to make the kernel mailing list, but even just the summary says
> something:
>
>  4998 total commits
>  6535 files changed, 414890 insertions(+), 233881 deletions(-)
>
> so please give it a good testing, and let's see if there are any
> regressions.
>

2.6.19-rc1-git2 :

...
  CC      arch/i386/mm/pgtable.o
  CC      arch/i386/mach-voyager/voyager_basic.o
  CC      arch/i386/mm/fault.o
  CC      arch/i386/kernel/ptrace.o
arch/i386/mach-voyager/voyager_basic.c:170: error: conflicting types
for 'voyager_timer_inte
rrupt'
include/asm/voyager.h:508: error: previous declaration of
'voyager_timer_interrupt' was here
arch/i386/mach-voyager/voyager_basic.c:170: error: conflicting types
for 'voyager_timer_inte
rrupt'
include/asm/voyager.h:508: error: previous declaration of
'voyager_timer_interrupt' was here
make[1]: *** [arch/i386/mach-voyager/voyager_basic.o] Error 1
make: *** [arch/i386/mach-voyager] Error 2
make: *** Waiting for unfinished jobs....
  CC      arch/i386/kernel/time.o
In file included from arch/i386/kernel/time.c:74:
include/asm-i386/mach-voyager/do_timer.h: In function `do_timer_interrupt_hook':
include/asm-i386/mach-voyager/do_timer.h:8: error: `irq_regs'
undeclared (first use in this
function)
include/asm-i386/mach-voyager/do_timer.h:8: error: (Each undeclared
identifier is reported o
nly once
include/asm-i386/mach-voyager/do_timer.h:8: error: for each function
it appears in.)
make[1]: *** [arch/i386/kernel/time.o] Error 1
make[1]: *** Waiting for unfinished jobs....
  CC      arch/i386/mm/ioremap.o
make: *** [arch/i386/kernel] Error 2


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
