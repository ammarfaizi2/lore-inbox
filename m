Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbVKWTZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbVKWTZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 14:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbVKWTZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 14:25:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28385 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932223AbVKWTZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 14:25:28 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <376.1132773809@warthog.cambridge.redhat.com> 
References: <376.1132773809@warthog.cambridge.redhat.com>  <Pine.LNX.4.64.0511231109040.13959@g5.osdl.org> <dhowells1132772387@warthog.cambridge.redhat.com> 
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org, dalomar@serrasold.com,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH 1/3] NOMMU: Provide shared-writable mmap support on ramfs 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Wed, 23 Nov 2005 19:25:18 +0000
Message-ID: <459.1132773918@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> > Truncate is _supposed_ to get rid of any shared mmap stuff. 
> 
> Yeah... but under _NOMMU_ conditions, it can't. There's no MMU around to
> enforce the fact that the mapping has been shrunk.

I may not have mentioned, but this does not apply under MMU conditions. A
different file in fs/ramfs/ swings into action and does the normal thing.

David
