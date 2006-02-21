Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161384AbWBUFzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161384AbWBUFzv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 00:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161385AbWBUFzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 00:55:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59353 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161384AbWBUFzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 00:55:50 -0500
Date: Mon, 20 Feb 2006 21:54:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Request for export of truncate_complete_page
Message-Id: <20060220215410.5990c612.akpm@osdl.org>
In-Reply-To: <20060220223810.GD5733@linuxhacker.ru>
References: <20060220223810.GD5733@linuxhacker.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin <green@linuxhacker.ru> wrote:
>
> Hello!
> 
>    Can I ask for truncate_complete_page() to be exported?
>    For Lustre filesystem it is necessary to poke out pages in the middle of
>    a file, but truncate_inode_pages() is not very suitable, because we
>    poke those pages one at a time when locks on those pages are cancelled, but
>    we cannot kill entire set of pages as a group, because there might be some
>    other lock that covers a subset of those pages, so we still need to iterate
>    through all of them, and while we are at it, it is easier to kill pages
>    as we check them one by one.
> 

Isn't truncate_inode_pages_range() suitable?

> +EXPORT_SYMBOL(truncate_complete_page);

_GPL would be nicer.   Plus a comment to keep people from "cleaning it up".

