Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261669AbSLTMJX>; Fri, 20 Dec 2002 07:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261686AbSLTMJX>; Fri, 20 Dec 2002 07:09:23 -0500
Received: from ns.suse.de ([213.95.15.193]:29715 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261669AbSLTMJW>;
	Fri, 20 Dec 2002 07:09:22 -0500
To: William Lee Irwin III <wli@holomorphy.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, bjorn_helgaas@hp.com
Subject: Re: [PATCH] Fix CPU bitmask truncation
References: <200212161213.29230.bjorn_helgaas@hp.com>
	<20021220103028.GB9704@holomorphy.com>
X-Yow: How's it going in those MODULAR LOVE UNITS??
From: Andreas Schwab <schwab@suse.de>
Date: Fri, 20 Dec 2002 13:17:24 +0100
In-Reply-To: <20021220103028.GB9704@holomorphy.com> (William Lee Irwin III's
 message of "Fri, 20 Dec 2002 02:30:28 -0800")
Message-ID: <je7ke4yje3.fsf@sykes.suse.de>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.3.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> writes:

|> ===== include/linux/init_task.h 1.19 vs edited =====
|> --- 1.19/include/linux/init_task.h	Sun Sep 29 07:02:55 2002
|> +++ edited/include/linux/init_task.h	Fri Dec 20 02:22:04 2002
|> @@ -63,7 +63,7 @@
|>  	.prio		= MAX_PRIO-20,					\
|>  	.static_prio	= MAX_PRIO-20,					\
|>  	.policy		= SCHED_NORMAL,					\
|> -	.cpus_allowed	= -1,						\
|> +	.cpus_allowed	= ~0UL,						\

This is useless.  Assigning -1 to any unsigned type is garanteed to give
you all bits one, and with two's complement this also holds for any signed
type.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
