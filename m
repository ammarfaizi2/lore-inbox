Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWDJLLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWDJLLI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 07:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWDJLLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 07:11:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13545 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751137AbWDJLLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 07:11:06 -0400
Date: Mon, 10 Apr 2006 03:10:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: sam@ravnborg.org, zippel@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/19] kconfig: move .kernelrelease
Message-Id: <20060410031023.22082c28.akpm@osdl.org>
In-Reply-To: <20060410025851.641022a0.akpm@osdl.org>
References: <Pine.LNX.4.64.0604091728560.23148@scrub.home>
	<20060410015727.69b5c1f6.akpm@osdl.org>
	<20060410104250.GA24160@mars.ravnborg.org>
	<20060410025851.641022a0.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> I stopped using `make kernelrelease' when it did something bad when used
>  from another machine across NFS.
> 
>  <tries it>
> 
>  hm, it takes nearly five seconds, but it wasn't that - something actually
>  broke.  But I forget what it was.  I'll put it back and will wait for it
>  to reoccur.
> 

Actually, I think it was a problem interacting with the weird things which
`git bisect' does with .kernelrelease.

bix:/usr/src/git26> git bisect start
bix:/usr/src/git26> git bisect bad v2.6.15
bix:/usr/src/git26> git bisect good v2.6.14
Bisecting:    2705 revisions left to test after this
bix:/usr/src/git26> cat .kernelrelease 
2.6.16-rc2-g6bd0e10e
bix:/usr/src/git26> make kernelrelease
2.6.14-gref: ref

That's cute, but it wasn't that..
