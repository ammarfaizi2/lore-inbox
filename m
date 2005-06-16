Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbVFPUrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVFPUrK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 16:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbVFPUrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 16:47:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44470 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261764AbVFPUrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 16:47:07 -0400
Date: Thu, 16 Jun 2005 13:41:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: drummond@valinux.com, davidm@hpl.hp.com, eranian@hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [resend][PATCH] avoid signed vs unsigned comparison in
 efi_range_is_wc()
Message-Id: <20050616134126.264d6bd5.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0506162219040.2477@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0506162219040.2477@dragon.hyggekrogen.localhost>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> wrote:
>
> I send in the patch below a while back but never recieved any response.
> Now I'm resending it in the hope that it might be added to -mm.

There are surely many warnings in the tree, hence I'm not really interested
in patches which only fix `gcc -W' warnings.

How many are there?

> It looks to me like a significantly large 'len' passed in could cause the 
> loop to never end. Isn't it safer to make 'i' an unsigned long as well? 

Nope.  All operations which mix signed and unsigned types promote the
signed type to unsigned.

