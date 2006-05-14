Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWENJvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWENJvJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 05:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWENJvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 05:51:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57800 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751389AbWENJvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 05:51:08 -0400
Date: Sun, 14 May 2006 02:47:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Evgeniy Dushistov <dushistov@mail.ru>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] ufs: ufs_trunc_indirect: infinite cycle
Message-Id: <20060514024752.2d666443.akpm@osdl.org>
In-Reply-To: <20060514081807.GA9802@rain.homenetwork>
References: <20060514081807.GA9802@rain.homenetwork>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Dushistov <dushistov@mail.ru> wrote:
>
> The situation the same: in ufs_trunc_(not direct),
>  we read block,
>  check if count of links to it is equal to one, 
>  if so we finish cycle, if not continue.
>  Because of "count of links" always >=2 this operation cause 
>  infinite cycle and hang up the kernel.

okay, but do we know what that code which you removed was actually intended
to do?

Do you know whether 2.4 kernels exhibit the same bug?  If not, we might have
accidentally broken UFS at some stage.
