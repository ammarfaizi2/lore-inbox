Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbTESKIT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 06:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbTESKIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 06:08:19 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:32920 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262239AbTESKIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 06:08:18 -0400
Date: Mon, 19 May 2003 03:23:25 -0700
From: Andrew Morton <akpm@digeo.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, drepper@redhat.com
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3
Message-Id: <20030519032325.4ed2dea3.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0305191103500.5653-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0305191103500.5653-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 May 2003 10:21:10.0814 (UTC) FILETIME=[5E4FA3E0:01C31DF0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
>  +	page1 = __pin_page(uaddr1 - offset1);
>  +	if (!page1) {
>  +		unlock_futex_mm();
>  +		return -EFAULT;
>  +	}
>  +	page2 = __pin_page(uaddr2 - offset2);
>  +	if (!page2) {
>  +		unlock_futex_mm();
>  +		return -EFAULT;
>  +	}

page1 is leaked.

