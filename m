Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266486AbUGBHeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266486AbUGBHeP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 03:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266492AbUGBHeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 03:34:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:54952 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266486AbUGBHeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 03:34:12 -0400
Date: Fri, 2 Jul 2004 00:33:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Yichen Xie <yxie@cs.stanford.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUGS] [CHECKER] 99 synchronization bugs and a lock summary
 database
Message-Id: <20040702003312.261032a7.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0407020008190.5069-100000@localhost.localdomain>
References: <20040701213837.0b97c21e.akpm@osdl.org>
	<Pine.LNX.4.44.0407020008190.5069-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yichen Xie <yxie@cs.stanford.edu> wrote:
>
>  > AFAICT fs/sysv/itree.c:find_shared is innocent.
> 
>  I guess here's what has triggered the warning by the tool:
> 
>  get_branch may try to acquire pointers_lock (itree.c:103) on one of its
>  paths, which was held (line 287) by find_shared...

OK, that's certainly very broken.   I'll fix that one up.


