Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270443AbTG1SZh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 14:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270444AbTG1SZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 14:25:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:22929 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270443AbTG1SZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 14:25:33 -0400
Date: Mon, 28 Jul 2003 11:40:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: kernel@kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O10int for interactivity
Message-Id: <20030728114041.2c8ce156.akpm@osdl.org>
In-Reply-To: <200307281808.h6SI8C5k004439@turing-police.cc.vt.edu>
References: <200307280112.16043.kernel@kolivas.org>
	<200307281808.h6SI8C5k004439@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> I am, however, able to get 'xmms' to skip.  The reason is that the CPU is being
>  scheduled quite adequately, but I/O is *NOT*.
> 
> ...
>  I'm guessing that the anticipatory scheduler is the culprit here.  Soon as I figure
>  out the incantations to use the deadline scheduler, I'll report back....

Try decreasing the expiry times in /sys/block/hda/queue/iosched:

read_batch_expire
read_expire
write_batch_expire
write_expire

