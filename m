Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbVHWGcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbVHWGcV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 02:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbVHWGcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 02:32:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9615 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750791AbVHWGcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 02:32:21 -0400
Date: Mon, 22 Aug 2005 23:30:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hans-Joachim Baader <hjb@pro-linux.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Process in D state with st driver
Message-Id: <20050822233051.4f8fa377.akpm@osdl.org>
In-Reply-To: <20050823054333.GA3360@kiwi.hjbaader.home>
References: <20050823054333.GA3360@kiwi.hjbaader.home>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans-Joachim Baader <hjb@pro-linux.de> wrote:
>
> I do nightly backups on tape. Every 3 to 4 weeks a process is stuck in
>  D state while accessing the drive:
> 
>  12398 ?        D      0:00 /usr/sbin/amcheck -ms daily
> 
>  There are no messages in the log. Only a reboot can remove this process.

Next time it happens, do

	dmesg -c
	echo t > /proc/sysrq-trigger
	dmesg -s 1000000 > foo

and send foo, thanks.
