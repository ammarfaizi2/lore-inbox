Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbWEBGNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWEBGNk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 02:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWEBGNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 02:13:40 -0400
Received: from pproxy.gmail.com ([64.233.166.183]:46239 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932387AbWEBGNj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 02:13:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ht7bSx1jL1FznGLmROquS8BOHri6Zi+ru4dcD7sSyzSZuAg+cXVbepKK0mnZ9tU0CbDeUNacl2cfXeD0WtAdK0qmlbfvZ7f8yEOc4zCqT+mXqGd5fa2VRKqVY4xT7VqYJbhO3DJBRrN6VEShudzhmpw2bZQxIoFv4YxAEBwdcXk=
Message-ID: <3420082f0605012313k767c20aage4de6bf8c5e736f@mail.gmail.com>
Date: Tue, 2 May 2006 11:13:38 +0500
From: "Irfan Habib" <irfan.habib@gmail.com>
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Subject: Re: Linux Kernel and Webservices
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200605020409.k4249EiJ007414@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3420082f0605011951m43479a98ie56a0a5f62409dd2@mail.gmail.com>
	 <200605020409.k4249EiJ007414@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If DNS is not available then, I can access system directly via the IP
address. Is it possible for a kernel level deamon to listen to some
ports, inorder for inserting things directly into the kernel, via some
remote machines?


On 5/2/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> On Tue, 02 May 2006 07:51:18 +0500, Irfan Habib said:
> > I wanted to know if modulescan be developed in the linux kernel, which
> > can create TCP/UDP sockets and communicate with perhaps webservices,
> > residing in the user level in the same computer or in some other
> > computer.
>
> > Is a networking API available in the linux kernel which can be used by
> > linux kernel modules, if so is there any documentation for it?
>
> It's generally considered a Bad Idea, as it's almost certainly easier to
> do in userspace.  If you're trying to to instrument a network-based monitoring
> system and need access to kernel data, you're *much* better off having the
> kernel export the data via netlink or even abuse of /proc or /sys, and then
> a small userspace program read the data and ship it over the net.  There's
> a *lot* of things that you just won't have access to in kernel space (for
> starters, you don't have a DNS resolver, so you can't use hostnames for
> configuration).
>
> If you're determined to do this in kernelspace anyhow, see the
> linux-2.6-tux.patch in recent RedHat/Fedora kernels, and ask yourself why
> that patch has no hope of being accepted upstream (although I have a great
> amount of respect for a lot of things that come out of RedHat, *that* patch
> is best described  "a fully RFC1925-compliant networking pig, with afterburners")
>
>
>
>
