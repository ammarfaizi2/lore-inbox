Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbUC1Uc5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 15:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbUC1Uc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 15:32:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:46000 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262461AbUC1Ucx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 15:32:53 -0500
Date: Sun, 28 Mar 2004 12:32:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, axboe@suse.de, wli@holomorphy.com,
       nickpiggin@yahoo.com.au, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] speed up SATA
Message-Id: <20040328123240.4332964e.akpm@osdl.org>
In-Reply-To: <406720A7.1050501@pobox.com>
References: <4066021A.20308@pobox.com>
	<200403282030.11743.bzolnier@elka.pw.edu.pl>
	<20040328183010.GQ24370@suse.de>
	<200403282045.07246.bzolnier@elka.pw.edu.pl>
	<406720A7.1050501@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
>  I like generic tunables such as "laptop mode" or "low latency" or "high 
>  throughput".  These sorts of tunables should affect the "automagic" 
>  calculations.

Not sure.  Things like "low latency" and "high throughput" may need other
things, such as "seek latency" and "bandwidth" as _inputs_, not as outputs.

Such device parameters should have reasonable defaults, and use a userspace
app which runs a quick seek latency and bandwidth test at mount-time,
poking the results into sysfs.
