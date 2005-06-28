Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262523AbVF1E02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262523AbVF1E02 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 00:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbVF1E01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 00:26:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60810 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262523AbVF1EZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 00:25:52 -0400
Date: Mon, 27 Jun 2005 21:25:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: earny@net4u.de, linux-kernel@vger.kernel.org
Subject: Re: dirty md raid5 slab bio leak
Message-Id: <20050627212511.11402fd1.akpm@osdl.org>
In-Reply-To: <17088.52861.78252.726904@cse.unsw.edu.au>
References: <200506272222.51993.list-lkml@net4u.de>
	<17088.41384.864708.23860@cse.unsw.edu.au>
	<17088.52861.78252.726904@cse.unsw.edu.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@cse.unsw.edu.au> wrote:
>
> It's OK, I found it.  The bio leaks when writing the md superblock.
> 

Thanks.

>  insert a missing bio_put when writting the md superblock.

Does 2.6.12.x need this?
