Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752190AbWKFSbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190AbWKFSbR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 13:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752148AbWKFSbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 13:31:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39296 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751004AbWKFSbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 13:31:16 -0500
Subject: Re: [PATCH] make last_inode counter in new_inode 32-bit on kernels
	that offer x86 compatability
From: Jeff Layton <jlayton@redhat.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061106182222.GO27140@parisc-linux.org>
References: <1162836725.6952.28.camel@dantu.rdu.redhat.com>
	 <20061106182222.GO27140@parisc-linux.org>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 13:31:14 -0500
Message-Id: <1162837874.12129.1.camel@dantu.rdu.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-06 at 11:22 -0700, Matthew Wilcox wrote:
> On Mon, Nov 06, 2006 at 01:12:05PM -0500, Jeff Layton wrote:
> > The attached patch remedies this by making the last_inode counter be an
> > unsigned int on kernels that have ia32 compatability mode enabled.
> 
> ... and this only happens on ia64/x86_64 kernels, not sparc64, ppc64,
> s390x, parisc64 or mips64?
> 

Yeah, that was my big question. I'd only seen this on ia32 compatability
modes, but clearly its a problem where unsigned long is a different size
between a 64-bit kernel and its 32-bit compatability mode.

I'll have a look at CONFIG_COMPAT and likely respin.

Thanks,
Jeff


