Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbVLBC7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbVLBC7O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 21:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbVLBC7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 21:59:14 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:11917 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964819AbVLBC7N convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 21:59:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nSnmRyarzPosRd7c0BAFEjB1qSx/cLANrVkIPDWuLUO6sbBN3VVxbNoNeldK8XHuy/hapfehQ9JkBcHXxEgPdeRVNWh5lj7Dq6VBQMVKUoUbzYwxeEK+nds7DmgF95cfsykdL/sGC3RNtcmg2Z++WbCIdQZoedfW/vto9AzHUHc=
Message-ID: <2cd57c900512011859v7f0db82fg@mail.gmail.com>
Date: Fri, 2 Dec 2005 10:59:11 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [q] make modules_install as non-root?
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, sam@ravnborg.org
In-Reply-To: <438FB582.3090002@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2cd57c900512011823v153a6763t@mail.gmail.com>
	 <438FB582.3090002@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/12/2, Peter Williams <pwil3058@bigpond.net.au>:
> Coywolf Qi Hunt wrote:
> > Hello people,
> >
> > I wrote my own installkernel so I can do `make install' as non-root
> > with the help of sudo. But how can we get to do `make modules_install'
> > as non-root with sudo as well?
> >
> > The works of modules_install seem scattered over several places.  Is
> > it a nice idea to factor out an *installmodules* script for `make
> > modules_install' to invoke?
> >
> > ps:
> > Linus recommend us to build as non-root and install as root.
> > I ask if we should install as non-root too.
>
> Personally, I just use "sudo make install" or "sudo make
> modules_install" to do installations as an ordinary user.  No need for
> special scripts or modifications to the build procedure.

That's rather insecure. You have to add /usr/bin/make in your sudoers,
then an malicious Makefile could do harm. I'm being paranoid. But we
all are since we avoid to use root.
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
