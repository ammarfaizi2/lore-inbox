Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265044AbUIIXOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265044AbUIIXOz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 19:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266582AbUIIXOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 19:14:55 -0400
Received: from the-village.bc.nu ([81.2.110.252]:32942 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265044AbUIIXOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 19:14:54 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org, mista.tapas@gmx.net, kr@cybsft.com,
       Mark_H_Johnson@Raytheon.com
In-Reply-To: <20040909224535.GN3106@holomorphy.com>
References: <20040903120957.00665413@mango.fruits.de>
	 <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu>
	 <20040906110626.GA32320@elte.hu>
	 <1094626562.1362.99.camel@krustophenia.net> <20040909192924.GA1672@elte.hu>
	 <20040909130526.2b015999.akpm@osdl.org>
	 <20040909224535.GN3106@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094767887.15731.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 09 Sep 2004 23:11:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-09 at 23:45, William Lee Irwin III wrote:
> Something odd is going on, in part because I get *blistering* IO speeds
> running benchmarks like dbench, tiobench, et al on tmpfs with striped
> swap. In fact, IO speeds markedly faster than any other filesystem I've
> ever tried, by about 30MB/s (i.e. wirespeed, where others fall about
> 37.5% short of it). Virtual alignment issues do hurt, but the core
> allocation algorithm appears to be better than good, it's astounding.

Thats a very atypical load where you can expect to get long linear write
outs. The seek v write numbers for a disk nowdays have more in common
with a tape drive. Paging tends to be much much more random.

Alan

