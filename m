Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbWEYQXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbWEYQXq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 12:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbWEYQXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 12:23:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55948 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030244AbWEYQXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 12:23:44 -0400
Date: Thu, 25 May 2006 09:23:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, wfg@mail.ustc.edu.cn
Subject: Re: [PATCH 04/33] readahead: page flag PG_readahead
Message-Id: <20060525092311.0523d8bf.akpm@osdl.org>
In-Reply-To: <348469537.16036@ustc.edu.cn>
References: <20060524111246.420010595@localhost.localdomain>
	<348469537.16036@ustc.edu.cn>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
>
> An new page flag PG_readahead is introduced as a look-ahead mark, which
> reminds the caller to give the adaptive read-ahead logic a chance to do
> read-ahead ahead of time for I/O pipelining.
> 
> It roughly corresponds to `ahead_start' of the stock read-ahead logic.
> 

This isn't a very revealing description of what this flag does.

> +#define __SetPageReadahead(page) __set_bit(PG_readahead, &(page)->flags)

uh-oh.  This is extremly risky.  Needs extensive justification, please.
