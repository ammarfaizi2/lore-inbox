Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbTEZXND (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 19:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbTEZXNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 19:13:02 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:9333 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262284AbTEZXNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 19:13:02 -0400
Date: Mon, 26 May 2003 16:26:16 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: davem@redhat.com, davidsen@tmr.com, haveblue@us.ibm.com,
       habanero@us.ibm.com, mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
Message-Id: <20030526162616.6ceacaba.akpm@digeo.com>
In-Reply-To: <20030526222406.GU3767@dualathlon.random>
References: <60830000.1053575867@[10.10.2.4]>
	<Pine.LNX.3.96.1030522130544.19863B-100000@gatekeeper.tmr.com>
	<20030522.154410.104047403.davem@redhat.com>
	<20030526222406.GU3767@dualathlon.random>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 May 2003 23:26:14.0451 (UTC) FILETIME=[33288030:01C323DE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
>  	if (IRQ_ALLOWED(phys_id, allowed_mask) && idle_cpu(phys_id))
>  		return cpu;

How hard would it be to make this HT-aware?

	idle_cpu(phys_id) && idle_cpu_siblings(phys_id)

or whatever.

