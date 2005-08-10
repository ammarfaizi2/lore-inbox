Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932530AbVHJJgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbVHJJgp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 05:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbVHJJgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 05:36:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59598 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932526AbVHJJgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 05:36:44 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050810080057.GA5295@lst.de> 
References: <20050810080057.GA5295@lst.de> 
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] consolidate sys_ptrace 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.4
Date: Wed, 10 Aug 2005 10:36:31 +0100
Message-ID: <25167.1123666591@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> The sys_ptrace boilerplate code (everything outside the big switch
> statement for the arch-specific requests) is shared by most
> architectures.  This patch moves it to kernel/ptrace.c and leaves the
> arch-specific code as arch_ptrace.

Looks okay for FRV.

My biggest concern with doing things like this is that it eats away at the
kernel stack space available for a syscall, though I don't think it'll be too
much of a problem in this case.

Is there also a way to get rid of the lock_kernel() call?

David
