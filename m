Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264282AbTEGVz2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 17:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264293AbTEGVz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 17:55:28 -0400
Received: from [12.47.58.20] ([12.47.58.20]:61217 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S264282AbTEGVz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 17:55:27 -0400
Date: Wed, 7 May 2003 15:04:14 -0700
From: Andrew Morton <akpm@digeo.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: rddunlap@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: The magical mystical changing ethernet interface order
Message-Id: <20030507150414.1eaeae75.akpm@digeo.com>
In-Reply-To: <20030507181410.A19615@flint.arm.linux.org.uk>
References: <20030507141458.B30005@flint.arm.linux.org.uk>
	<20030507082416.0996c3df.rddunlap@osdl.org>
	<20030507181410.A19615@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 May 2003 22:07:55.0144 (UTC) FILETIME=[1C4DE880:01C314E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> wrote:
>
> A wild stab in the dark, I'd think maybe the init ordering changed:

Well stabbed.  The relative ordering of tulip and ne2k in
drivers/net/Makefile got changed.

Maybe we should reorganise the 2.5 Makefile to copy the 2.4 Makefile's
ordering.  How pleasant.

I suspect the linker is at liberty to reorder these anyway.
