Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTHCTbG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 15:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267517AbTHCTbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 15:31:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:42698 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262123AbTHCTbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 15:31:05 -0400
Date: Sun, 3 Aug 2003 12:32:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: bert hubert <ahu@ds9a.nl>
Cc: linux-kernel@vger.kernel.org, devik@cdi.cz
Subject: Re: [PATCH] Allow /dev/{,k}mem to be disabled to prevent kernel
 from being modified easily
Message-Id: <20030803123218.7bb2c16f.akpm@osdl.org>
In-Reply-To: <20030803180950.GA11575@outpost.ds9a.nl>
References: <20030803180950.GA11575@outpost.ds9a.nl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert <ahu@ds9a.nl> wrote:
>
>  +#if defined(CONFIG_MEMORY_ACCESS)
>   	{1, "mem",     S_IRUSR | S_IWUSR | S_IRGRP, &mem_fops},
>   	{2, "kmem",    S_IRUSR | S_IWUSR | S_IRGRP, &kmem_fops},
>  +#endif	

Well if you're going to do this, wouldn't it be better to force a segv and
drop some messages in syslog?

