Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbVIQEmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbVIQEmc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 00:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbVIQEmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 00:42:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60634 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750905AbVIQEmb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 00:42:31 -0400
Date: Fri, 16 Sep 2005 21:41:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: avuton@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc1-mm1
Message-Id: <20050916214155.29f56f30.akpm@osdl.org>
In-Reply-To: <3aa654a4050916182250999557@mail.gmail.com>
References: <20050916022319.12bf53f3.akpm@osdl.org>
	<3aa654a4050916182250999557@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avuton Olrich <avuton@gmail.com> wrote:
>
>  On 9/16/05, Andrew Morton <akpm@osdl.org> wrote:
>  > 
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc1/2.6.14-rc1-mm1/
>  > (temp copy at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.14-rc1-mm1.gz)
> 
>  NFS (server) is not working for me with 2.6.14-rc1-mm1, this doesn't
>  appear to be an NFS4 specific issue, I tried without NFS4 compiled in.
> 
>  Going back to 2.6.13-mm1 works.
> 
>  When trying to start NFS I get:
>  nfssvc: Permission Denied

It all works for me.  Would it be possible for you to generate an strace of
the failure?   Something like

	strace -f -o log service nfs start

Do the same on 2.6.14-rc1, compare the two traces, identify where the
failure occurrs?
