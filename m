Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbSLTRFS>; Fri, 20 Dec 2002 12:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262807AbSLTRFS>; Fri, 20 Dec 2002 12:05:18 -0500
Received: from holomorphy.com ([66.224.33.161]:37318 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262796AbSLTRFR>;
	Fri, 20 Dec 2002 12:05:17 -0500
Date: Fri, 20 Dec 2002 09:12:43 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andreas Schwab <schwab@suse.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, bjorn_helgaas@hp.com
Subject: Re: [PATCH] Fix CPU bitmask truncation
Message-ID: <20021220171243.GD9704@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andreas Schwab <schwab@suse.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, bjorn_helgaas@hp.com
References: <200212161213.29230.bjorn_helgaas@hp.com> <20021220103028.GB9704@holomorphy.com> <je7ke4yje3.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <je7ke4yje3.fsf@sykes.suse.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
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

On Fri, Dec 20, 2002 at 01:17:24PM +0100, Andreas Schwab wrote:
> This is useless.  Assigning -1 to any unsigned type is garanteed to give
> you all bits one, and with two's complement this also holds for any signed
> type.

Not so on all gcc versions. The rest of the world can figure out what
to do about the versions that do not.


Bill
