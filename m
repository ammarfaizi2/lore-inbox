Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262985AbTENWPO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 18:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbTENWPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 18:15:14 -0400
Received: from pop.gmx.net ([213.165.64.20]:25583 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262985AbTENWPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 18:15:13 -0400
Message-ID: <3EC2C2E3.8030007@gmx.net>
Date: Thu, 15 May 2003 00:27:47 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Oleg Drokin <green@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK] [PATCH] [2.4] ReiserFS export balance_dirty
References: <3EC28D47.4020909@namesys.com>
In-Reply-To: <3EC28D47.4020909@namesys.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> Subject:
> [PATCH] [2.4] export balance_dirty
> From:
> Oleg Drokin <green@namesys.com>
> 
> ===== fs/buffer.c 1.82 vs edited =====
> --- 1.82/fs/buffer.c	Mon Dec 16 09:22:07 2002
> +++ edited/fs/buffer.c	Wed May 14 16:51:00 2003
> @@ -1026,6 +1026,7 @@
>  		write_some_buffers(NODEV);
>  	}
>  }
> +EXPORT_SYMBOL(balance_dirty);
>  
>  inline void __mark_dirty(struct buffer_head *bh)
>  {

Any reason why you don't put this in ksyms.c?
This is a honest question, no flamebait.


Carl-Daniel

