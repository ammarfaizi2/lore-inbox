Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932697AbWAMCdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932697AbWAMCdn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 21:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932682AbWAMCdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 21:33:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20458 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932697AbWAMCdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 21:33:42 -0500
Date: Thu, 12 Jan 2006 18:33:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Takashi Sato" <sho@tnes.nec.co.jp>
Cc: torvalds@osdl.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: Re: [PATCH 2/3] Fix problems on multi-TB filesystem and file
Message-Id: <20060112183319.526b877a.akpm@osdl.org>
In-Reply-To: <000101c611df$6d64f570$4168010a@bsd.tnes.nec.co.jp>
References: <000101c611df$6d64f570$4168010a@bsd.tnes.nec.co.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Takashi Sato" <sho@tnes.nec.co.jp> wrote:
>
>  This is a patch to add blkcnt_t as the type of inode.i_blocks.
>  This enables you to make the size of blkcnt_t either 4 bytes or 8 bytes
>  on 32 bits architecture with CONFIG_LSF.

What was the rationale behind CONFIG_LSF?  It's a bit of an ugly thing and
I'm wondering if we wouldn't be better off just removing it and simply
fixing >2TB support for all .configs?

Do the common userspace tools need to be updated for this, or do they
already get it right?
