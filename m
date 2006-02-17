Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161149AbWBQHLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161149AbWBQHLc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 02:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbWBQHLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 02:11:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50921 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932533AbWBQHLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 02:11:31 -0500
Date: Thu, 16 Feb 2006 23:10:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: earny@net4u.de
Cc: list-lkml@net4u.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc3 macromedia flash regression...
Message-Id: <20060216231014.6c2ae214.akpm@osdl.org>
In-Reply-To: <200602170508.52712.list-lkml@net4u.de>
References: <200602170508.52712.list-lkml@net4u.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ernst Herzberg <list-lkml@net4u.de> wrote:
>
> .... or not regession, that's the question.
> 
>  2.6.16-rc2 works without problems.
> 
>  With -rc3 a .swf that opens a ip connection back to the server takes ages to 
>  load. strace shows that the player hangs for long times in select().
>
>  Digging through the changelog brings up
> 
>  commit 643a654540579b0dcc7a206a4a7475276a41aff0
>  Author: Andrew Morton <akpm@osdl.org>
>  Date:   Sat Feb 11 17:55:52 2006 -0800
> 
>      [PATCH] select: fix returned timeval

Thanks for working that out.

Are you able to send along the relevant parts of the strace output, so we
see the select() inputs and outputs?
