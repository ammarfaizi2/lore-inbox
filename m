Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262568AbVCCUm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbVCCUm7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 15:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbVCCUkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 15:40:25 -0500
Received: from fire.osdl.org ([65.172.181.4]:19096 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262172AbVCCUfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 15:35:42 -0500
Date: Thu, 3 Mar 2005 12:34:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] BDI: Provide backing device capability information
Message-Id: <20050303123448.462c56cd.akpm@osdl.org>
In-Reply-To: <13767.1109857095@redhat.com>
References: <20050302135146.2248c7e5.akpm@osdl.org>
	<20050302090734.5a9895a3.akpm@osdl.org>
	<9420.1109778627@redhat.com>
	<31789.1109799287@redhat.com>
	<13767.1109857095@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> Andrew Morton <akpm@osdl.org> wrote:
> 
>  > 
>  > > +#define BDI_CAP_MAP_COPY	0x00000001	/* Copy can be mapped (MAP_PRIVATE) */
>  > > +#define BDI_CAP_MAP_DIRECT	0x00000002	/* Can be mapped directly (MAP_SHARED) */
>  > 
>  > Why not make these bitfields as well?
> 
>  Because I want to copy the capabilities mask (including these variables) into
>  a variable in the nommu mmap implementation and eliminate various bits from
>  that variable under certain conditions.
> 
>  Making these into bitfields would result in having to use three variables
>  instead of just the one.

Well let's do one or the other, and not have it half-and-half, please.
