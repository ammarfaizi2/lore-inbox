Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbVCGGin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVCGGin (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 01:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVCGGhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 01:37:39 -0500
Received: from mo00.iij4u.or.jp ([210.130.0.19]:24266 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261650AbVCGGh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 01:37:29 -0500
Date: Mon, 7 Mar 2005 15:37:17 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: yuasa@hh.iij4u.or.jp, akpm@osdl.org, linux-kernel@vger.kernel.org,
       ralf@linux-mips.org
Subject: Re: [PATCH 2.6.11-mm1] mips: more convert verify_area to access_ok
Message-Id: <20050307153717.24810dcb.yuasa@hh.iij4u.or.jp>
In-Reply-To: <Pine.LNX.4.62.0503070050390.2971@dragon.hygekrogen.localhost>
References: <20050306232450.104fd7b7.yuasa@hh.iij4u.or.jp>
	<Pine.LNX.4.62.0503070050390.2971@dragon.hygekrogen.localhost>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Mar 2005 00:55:30 +0100 (CET)
Jesper Juhl <juhl-lkml@dif.dk> wrote:

> On Sun, 6 Mar 2005, Yoichi Yuasa wrote:
> 
> > This patch converts verify_area to access_ok for include/asm-mips.
> > 
> Yeah, that's one of the few bits I had not done yet. Thank you for taking 
> a look at that.
> 
> I don't believe your patch is correct though. See below for what I think 
> is a better one.

That's right.
I forgot to assign 0 to __gu_err/__pu_err after access_ok().

Thanks,

Yoichi
