Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbVGaIJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVGaIJd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 04:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbVGaIJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 04:09:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63706 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261834AbVGaIJa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 04:09:30 -0400
Date: Sun, 31 Jul 2005 01:08:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: zghuo@ncic.ac.cn
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [PATCH] Fix PIPE_LEN definition in 2.6.12
Message-Id: <20050731010819.7d9404ba.akpm@osdl.org>
In-Reply-To: <1122796514.8909.17.camel@mypad>
References: <1122796514.8909.17.camel@mypad>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

_________  <zghuo@ncic.ac.cn> wrote:
>
> With the introduction of the new "struct pipe_inode_info"in 2.6.11,
>  the definition of PIPE_LEN, PIPE_BASE, PIPE_START all become
>  obsolete. The new definition of PIPE_LEN is attached.

bix:/usr/src/linux-2.6.13-rc4> grep -r PIPE_LEN .
./include/linux/pipe_fs_i.h:#define PIPE_LEN(inode)             ((inode).i_pipe->len)
bix:/usr/src/linux-2.6.13-rc4> 

We can just kill it, can't we?
