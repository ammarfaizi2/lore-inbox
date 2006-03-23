Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbWCWCC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbWCWCC5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 21:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbWCWCC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 21:02:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15850 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932512AbWCWCC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 21:02:56 -0500
Date: Wed, 22 Mar 2006 17:59:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mark Hindley <mark@hindley.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.16] Multiple cron hang in fork
Message-Id: <20060322175920.4d9b4a5b.akpm@osdl.org>
In-Reply-To: <20060322135840.GA12458@hindley.uklinux.net>
References: <20060322135840.GA12458@hindley.uklinux.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hindley <mark@hindley.org.uk> wrote:
>
> I have jut upgraded an Asus Aspire 1350 from 2.6.15.5 to 2.6.16 and I am
>  getting all the cron processes stuck in fork(). loadavg up to 20 and
>  rising! No problems with 2.6.15.x. Kernel upgrade is the only change

Please do 

	dmesg -c
	echo t > /proc/sysrq-trigger
	dmesg -c -s 1000000 > foo

and send foo, thanks.
