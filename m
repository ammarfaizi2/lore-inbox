Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966260AbWKYEwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966260AbWKYEwU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 23:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935146AbWKYEwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 23:52:19 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:10719 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S935145AbWKYEwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 23:52:19 -0500
Date: Fri, 24 Nov 2006 23:48:33 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: UML compile problems on -mm
Message-ID: <20061125044833.GA6470@ccure.user-mode-linux.org>
References: <E1GnXeZ-00052H-00@dorka.pomaz.szeredi.hu> <20061124203422.GE4745@ccure.user-mode-linux.org> <E1Gnjd8-0007Ee-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Gnjd8-0007Ee-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2006 at 11:34:46PM +0100, Miklos Szeredi wrote:
> You mean /asm-generic/vmlinux.lds.h?
> 
> That one defines the macro named BUG_TABLE, but does not use it.  And
> AFAICS neither does the other two files you mentioned.

Yup, I missed the '\'s over on the right.

> So there's somthing fishy going on ;)

Yes, somehow I have it, and I'm not sure how:
	(gdb) p &__start___bug_table
	$1 = (
	    <variable (not text or data), no debug info> *) 0x81aa61c "\ufffd\221\004\b\ufffd\ufffd\030\b\a\001"


				Jeff

-- 
Work email - jdike at linux dot intel dot com
