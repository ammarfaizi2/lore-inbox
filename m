Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWIVS1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWIVS1v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 14:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWIVS1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 14:27:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7062 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964866AbWIVS1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 14:27:40 -0400
Date: Fri, 22 Sep 2006 11:26:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>
Cc: David Miller <davem@davemloft.net>, jeff@garzik.org, davidsen@tmr.com,
       torvalds@osdl.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
Message-Id: <20060922112649.2b98cc2d.akpm@osdl.org>
In-Reply-To: <20060922154816.GA15032@redhat.com>
References: <Pine.LNX.4.64.0609211106391.4388@g5.osdl.org>
	<45130533.2010209@tmr.com>
	<45130527.1000302@garzik.org>
	<20060921.145208.26283973.davem@davemloft.net>
	<20060921220539.GL26683@redhat.com>
	<20060922083542.GA4246@flint.arm.linux.org.uk>
	<20060922154816.GA15032@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006 11:48:16 -0400
Dave Jones <davej@redhat.com> wrote:

>  > As far as -mm getting these, I have asked Andrew to pull this tree in
>  > the past, but whenever I rebase the trees (eg, when 2.6.18 comes out)
>  > and fix up the rejects, Andrew seems to have a hard time coping.  I
>  > guess Andrew finds it too difficult to handle my devel branches.
> 
> Has Andrew commented on why this is proving to be more of a problem?

I don't recall any particular ARM problems, so I'm curious too.  I'm
presently pulling git+ssh://master.kernel.org/home/rmk/linux-2.6-arm.git,
which is coming up empty.

OTOH, I doubt if anyone runtime tests -mm on arm.

OTOH^2, people do cross-compile.

OTOH^3, my attempts to build an arm cross-compiler haven't been very
successful.  I do have a .config which compiles, but allmodconfig used to
die due to the compiler not understanding weird `-m' options.  <tries it>. 
OK, that got fixed, so without CONFIG_AUDIT, arm allmodconfig compiles.  Am
happy.


<I maintain that it is in the interests of obscure-arch maintainers to help
others build cross-compilers for their arch..>

<how'd I fall off the cc?>

<looks at viro>

include/asm-generic/audit_dir_write.h:9: error: `__NR_mkdirat' undeclared here (not in a function)
include/asm-generic/audit_dir_write.h:9: error: initializer element is not constant
include/asm-generic/audit_dir_write.h:9: error: (near initialization for `dir_class[8]')
include/asm-generic/audit_dir_write.h:10: error: `__NR_mknodat' undeclared here (not in a function)
include/asm-generic/audit_dir_write.h:10: error: initializer element is not constant
include/asm-generic/audit_dir_write.h:10: error: (near initialization for `dir_class[9]')
include/asm-generic/audit_dir_write.h:11: error: `__NR_unlinkat' undeclared here (not in a function)

