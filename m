Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbUC1BDE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 20:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUC1BDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 20:03:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:26338 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262042AbUC1BDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 20:03:01 -0500
Date: Sat, 27 Mar 2004 17:02:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: nickpiggin@yahoo.com.au, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] speed up SATA
Message-Id: <20040327170257.24c82915.akpm@osdl.org>
In-Reply-To: <40662108.40705@pobox.com>
References: <4066021A.20308@pobox.com>
	<40661049.1050004@yahoo.com.au>
	<406611CA.3050804@pobox.com>
	<406616EE.80301@pobox.com>
	<4066191E.4040702@yahoo.com.au>
	<40662108.40705@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
>  TCQ-on-write for ATA disks is yummy because you don't really know what 
>  the heck the ATA disk is writing at the present time.  By the time the 
>  Linux disk scheduler gets around to deciding it has a nicely merged and 
>  scheduled set of requests, it may be totally wrong for the disk's IO 
>  scheduler.  TCQ gives the disk a lot more power when the disk integrates 
>  writes into its internal IO scheduling.

Slightly beneficial for throughput, disastrous for latency.

It appears the only way we'll ever get this gross misdesign fixed is to add
a latency test to winbench.

