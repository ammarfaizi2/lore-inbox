Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270508AbTGaXCs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 19:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270092AbTGaXAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 19:00:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:989 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274904AbTGaXAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 19:00:03 -0400
Date: Thu, 31 Jul 2003 15:47:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: joe.korty@ccur.com
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] protect migration/%d etc from sched_setaffinity
Message-Id: <20030731154740.4e21a6e2.akpm@osdl.org>
In-Reply-To: <20030731224604.GA24887@tsunami.ccur.com>
References: <20030731224604.GA24887@tsunami.ccur.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty <joe.korty@ccur.com> wrote:
>
> Lock out users from changing the cpu affinity of those per-cpu system
> daemons which cannot survive such a change, such as migration/%d.

Generally we prefer to not add code which purely protects root from making
mistakes.  Once the sysadmin has nuked his box he'll learn to not do it
again.

Or do you have some deeper reaon for needing this?

