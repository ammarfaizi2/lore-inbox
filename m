Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbTE0BqF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 21:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbTE0BqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 21:46:05 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:40827 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262430AbTE0BqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 21:46:04 -0400
Date: Mon, 26 May 2003 18:59:20 -0700
From: Andrew Morton <akpm@digeo.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: davem@redhat.com, andrea@suse.de, davidsen@tmr.com, haveblue@us.ibm.com,
       habanero@us.ibm.com, mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
Message-Id: <20030526185920.64e9751f.akpm@digeo.com>
In-Reply-To: <20030527015307.GC8978@holomorphy.com>
References: <20030527000639.GA3767@dualathlon.random>
	<20030526.171527.35691510.davem@redhat.com>
	<20030527004115.GD3767@dualathlon.random>
	<20030526.174841.116378513.davem@redhat.com>
	<20030527015307.GC8978@holomorphy.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 May 2003 01:59:17.0751 (UTC) FILETIME=[94D4E070:01C323F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> In
>  the userspace implementation the reprogramming is done infrequently
>  enough to make even significant cost negligible; in-kernel the cost
>  is entirely uncontrolled and the rate of reprogramming unlimited.

eh?

#define MAX_BALANCED_IRQ_INTERVAL       (5*HZ)
#define MIN_BALANCED_IRQ_INTERVAL       (HZ/2)
