Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264390AbTCXUWV>; Mon, 24 Mar 2003 15:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264391AbTCXUWU>; Mon, 24 Mar 2003 15:22:20 -0500
Received: from packet.digeo.com ([12.110.80.53]:3225 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264390AbTCXUWU>;
	Mon, 24 Mar 2003 15:22:20 -0500
Date: Mon, 24 Mar 2003 14:37:58 -0800
From: Andrew Morton <akpm@digeo.com>
To: davej@codemonkey.org.uk
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: cyclades region handling updates from 2.4
Message-Id: <20030324143758.66ed03fe.akpm@digeo.com>
In-Reply-To: <200303241641.h2OGft35008188@deviant.impure.org.uk>
References: <200303241641.h2OGft35008188@deviant.impure.org.uk>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Mar 2003 20:33:14.0988 (UTC) FILETIME=[987DE2C0:01C2F244]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@codemonkey.org.uk wrote:
>
> -static struct timer_list cyz_timerlist = TIMER_INITIALIZER(cyz_poll, 0, 0);
> +static struct timer_list cyz_timerlist = {
> +	.function = cyz_poll
> +};

errr, bit of regression there.  The spinlock in the timer is no longer
initialised.

