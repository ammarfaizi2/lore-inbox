Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWDIUnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWDIUnl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 16:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWDIUnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 16:43:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:410 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750761AbWDIUnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 16:43:40 -0400
Date: Sun, 9 Apr 2006 12:43:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Orlov <bugfixer@list.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc1-mm2: badness in 3w_xxxx driver
Message-Id: <20060409124301.44a9567c.akpm@osdl.org>
In-Reply-To: <20060409191256.GA4609@nickolas.homeunix.com>
References: <20060409182306.GA4680@nickolas.homeunix.com>
	<20060409113240.630b9a24.akpm@osdl.org>
	<20060409191256.GA4609@nickolas.homeunix.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Orlov <bugfixer@list.ru> wrote:
>
> Confirmed, this patch solves the "badness" problem for me.

yup, thanks.

>  I still experiencing a weird hangs though (the box just hangs, no
>  messages on console/syslog, nothing). I'll try to nail it down.
> 
>  2.6.16-mm2 works like a charm with the same config.
>  Do you know which patches should I try to revert first?

Gee, 2.6.16-mm2 was a long time ago.

Tried sysrq?

	echo 1 > /proc/sys/kernel/sysrq
	<wait for hang>
	ALT-SYSRQ-P or ALT-SYSRQ-T

Is the NMi watchdog enabled?  Boot with `nmi_watchdog=1', make sure that
the NMI counts are incrementing in /proc/interrupts.

Failing all that, testing 2.6.17-rc1 would be interesting.
