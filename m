Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262235AbVBKKOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbVBKKOi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 05:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbVBKKOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 05:14:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:1678 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262235AbVBKKOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 05:14:34 -0500
Date: Fri, 11 Feb 2005 02:14:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Junfeng Yang <yjf@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
Subject: Re: [CHECKER] Does sys_sync (ext2, 2.6.x) flush metadata?
Message-Id: <20050211021428.59dc2234.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.44.0502102345540.8091-100000@elaine24.Stanford.EDU>
References: <Pine.GSO.4.44.0502102345540.8091-100000@elaine24.Stanford.EDU>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junfeng Yang <yjf@stanford.edu> wrote:
>
> 
> Hi,
> 
> We're working on a file system checker and have a question regarding what
> sys_sync actually does.  It appears to us that sys_sync should sync both
> data and metadata, and wait until both data and metadata hit the disk
> before it returns.  Is this true for all the file systems (especially
> ext2) for kernel 2.6.x?

It should be.

>  I've gotten many "error" traces for ext2, where
> directory entries are not flushed to disk after sys_sync.

How?

>  In other words,
> even if users do call sys_sync, a crash after sys_sync call can still
> cause file losses.  Is this intended?

No.
