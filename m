Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbUCZXqv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 18:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbUCZXqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 18:46:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:51351 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261437AbUCZXqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 18:46:50 -0500
Date: Fri, 26 Mar 2004 15:48:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [EXT3/JBD] Periodic journal flush not enough?
Message-Id: <20040326154851.7a3ad417.akpm@osdl.org>
In-Reply-To: <20040326231958.GA484@gondor.apana.org.au>
References: <20040326231958.GA484@gondor.apana.org.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> I've encountered a problem with the journal flush timer.  The problem
> is that when a filesystem is short on space, relying on a timer-based
> flushing mechanism is no longer adequate.  For example, on my P4 2GHz
> I can trigger an ENOSPC error by doing
> 
> while :; do echo test > a; [ -s a ] || break; rm a; done; echo Out of space
> 
> on an ext3 file system with 12Mb of free space using the usual 5s
> journal flush timer.

I cannot reproduce this.  Please send more details.  Journalling mode,
kernel version, etc.

