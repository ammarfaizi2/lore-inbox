Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261743AbTCQPiB>; Mon, 17 Mar 2003 10:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261744AbTCQPiB>; Mon, 17 Mar 2003 10:38:01 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:14858 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261743AbTCQPiA>; Mon, 17 Mar 2003 10:38:00 -0500
Date: Mon, 17 Mar 2003 16:48:48 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andries.Brouwer@cwi.nl
cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix affs/super.c
In-Reply-To: <UTC200303171509.h2HF95N15581.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0303171647000.12110-100000@serv>
References: <UTC200303171509.h2HF95N15581.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 17 Mar 2003 Andries.Brouwer@cwi.nl wrote:

> Mounting a non-affs filesystem as affs crashes the kernel.
> The reason is the
> 	sbi = kmalloc(sizeof(struct affs_sb_info), GFP_KERNEL);
> 	memset(sbi, 0, sizeof(*AFFS_SB));
> where the second sizeof is 1, so that sbi is not zeroed at all.

Thanks, I found this bug last weekend too. :)
(But it hasn't left the m68k repository yet.)

> The patch below also does a little random polishing nearby.

Could you please keep this separate?

bye, Roman

