Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267869AbUHTSng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267869AbUHTSng (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 14:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266925AbUHTSnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 14:43:08 -0400
Received: from the-village.bc.nu ([81.2.110.252]:40841 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268667AbUHTSl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 14:41:57 -0400
Subject: Re: [PATCH] Resolve duplicate/conflicting MODULE_LICENSE tags
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1093018564.17135.33.camel@winden.suse.de>
References: <1093018564.17135.33.camel@winden.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093023561.31605.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 20 Aug 2004 18:39:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-20 at 17:16, Andreas Gruenbacher wrote:
> * drivers/net/ppp_mppe.ko has MODULE_LICENSE("BSD without advertisement
>   clause"). This is generally considered a GPL compatible license,
>   and should probably be added to license_is_gpl_compatible().
> 
> 
> Are we fine with applying the following patch?

This patch destroys the entire value of the module license system
unfortunately. I can put any code I like under a BSD license and not
give you the source and claim it is BSD licensed. I don't have to give
you the source, you can't demand it so anyone can claim that and it
would allow arbitary code without taint. Not good at all.

For code which is GPL licensed in the kernel but has other licenses
we have the tag "GPL and additional rights". This allows us to cover
licenses that are GPL compatible and where the GPL version of the rights
is in use in the kernel.

Alan



