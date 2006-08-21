Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWHUAfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWHUAfB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 20:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWHUAfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 20:35:01 -0400
Received: from mail.parknet.jp ([210.171.160.80]:17671 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932224AbWHUAfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 20:35:00 -0400
X-AuthUser: hirofumi@parknet.jp
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cfq_cic_link: fix? usage of wrong cfq_io_context
References: <20060820210903.GA6123@oleg>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 21 Aug 2006 09:34:49 +0900
In-Reply-To: <20060820210903.GA6123@oleg> (Oleg Nesterov's message of "Mon, 21 Aug 2006 01:09:03 +0400")
Message-ID: <877j13sz86.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

>  		if (unlikely(!k)) {
> -			cfq_drop_dead_cic(ioc, cic);
> +			cfq_drop_dead_cic(ioc, __cic);
>  			goto restart;
>  		}

Ugh, I think you are right, and it's my fault. Sorry.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
