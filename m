Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbVBKNSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbVBKNSk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 08:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbVBKNSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 08:18:40 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:15672 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262112AbVBKNRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 08:17:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Bk42nqOxQLj7m5HdIirWNTL1t6ACeiCYcCVpJ8KDFQid4Y+71Pg5j5NE1HYA2uzp+qXIgM3q80bW51RdMtghNcpvXL1z4nmaazntx1l///2hyLpUr7+rZM9oEgg7xnb0Kgnl64N229nsAhM6+sAtJxRRb/TXOqgynIZpO+9jqCs=
Message-ID: <58cb370e050211051752d0342c@mail.gmail.com>
Date: Fri, 11 Feb 2005 14:17:49 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Junfeng Yang <yjf@stanford.edu>
Subject: Re: [CHECKER] Does sys_sync (ext2, 2.6.x) flush metadata?
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mc@cs.stanford.edu
In-Reply-To: <Pine.GSO.4.44.0502102345540.8091-100000@elaine24.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.GSO.4.44.0502102345540.8091-100000@elaine24.Stanford.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 10 Feb 2005 23:59:53 -0800 (PST), Junfeng Yang <yjf@stanford.edu> wrote:
> 
> Hi,
> 
> We're working on a file system checker and have a question regarding what
> sys_sync actually does.  It appears to us that sys_sync should sync both
> data and metadata, and wait until both data and metadata hit the disk
> before it returns.  Is this true for all the file systems (especially
> ext2) for kernel 2.6.x?  I've gotten many "error" traces for ext2, where
> directory entries are not flushed to disk after sys_sync.  In other words,
> even if users do call sys_sync, a crash after sys_sync call can still
> cause file losses.  Is this intended?

I don't know what exactly you are doing but do you remember
about disabling write caching on your disks in case of doing
real hard crashes?

Regards,
Bartlomiej
