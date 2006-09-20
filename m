Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWITVzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWITVzl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 17:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWITVzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 17:55:41 -0400
Received: from pat.uio.no ([129.240.10.4]:39047 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932223AbWITVzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 17:55:40 -0400
Subject: Re: Autofs4 breakage (was 2.6.19 -mm merge plans)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060920135438.d7dd362b.akpm@osdl.org>
References: <20060920135438.d7dd362b.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 17:55:33 -0400
Message-Id: <1158789333.5639.37.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.808, required 12,
	autolearn=disabled, AWL 1.19, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 13:54 -0700, Andrew Morton wrote:

> add-newline-to-nfs-dprintk.patch
> fs-nfs-make-code-static.patch
> 
>  NFS queue -> Trond.
> 
>  The NFS git tree breaks autofs4 submounts.  Still.

I still suspect that is due to a misconfigured selinux setup on your
machine. If autofs4 expects to be able to do mkdir() on your NFS
partition (something which in itself is wrong), then selinux should be
configured to allow it to do so.

Anyhow, does reverting the patch

http://kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=a634904a7de0d3a0bc606f608007a34e8c05bfee;hp=ddeff520f02b92128132c282c350fa72afffb84a

'fix' the issue for you?

Cheers,
  Trond

