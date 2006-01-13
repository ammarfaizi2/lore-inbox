Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932703AbWAMCeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932703AbWAMCeT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 21:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbWAMCeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 21:34:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27114 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932682AbWAMCeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 21:34:17 -0500
Date: Thu, 12 Jan 2006 18:33:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Takashi Sato" <sho@tnes.nec.co.jp>
Cc: torvalds@osdl.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: Re: [PATCH 3/3] Fix problems on multi-TB filesystem and file
Message-Id: <20060112183354.03eaf2df.akpm@osdl.org>
In-Reply-To: <000201c611df$92dca230$4168010a@bsd.tnes.nec.co.jp>
References: <000201c611df$92dca230$4168010a@bsd.tnes.nec.co.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Takashi Sato" <sho@tnes.nec.co.jp> wrote:
>
> his fix was proposed by Trond Myklebust.  He says:
>   The type "sector_t" is heavily tied in to the block layer interface
>   as an offset/handle to a block, and is subject to a supposedly
>   block-specific configuration option: CONFIG_LBD. Despite this, it is
>   used in struct kstatfs to save a couple of bytes on the stack
>   whenever we call the filesystems' ->statfs().
> 
>  So kstatfs's entries related to blocks are invalid on statfs64 for a
>  network filesystem which has more than 2^32-1 blocks when CONFIG_LBD
>  is disabled.
> 

That makes sense, thanks.
