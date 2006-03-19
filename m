Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbWCSDuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWCSDuq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 22:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWCSDuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 22:50:46 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:18364 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750969AbWCSDup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 22:50:45 -0500
Subject: Re: [PATCH 07/23] readahead: insert cond_resched() calls
From: Lee Revell <rlrevell@joe-job.com>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Con Kolivas <kernel@kolivas.org>
In-Reply-To: <20060319023451.808130000@localhost.localdomain>
References: <20060319023413.305977000@localhost.localdomain>
	 <20060319023451.808130000@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 18 Mar 2006 22:50:42 -0500
Message-Id: <1142740242.4532.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-19 at 10:34 +0800, Wu Fengguang wrote:
> plain text document attachment
> (readahead-insert-cond_resched-calls.patch)
> Since the VM_MAX_READAHEAD is greatly enlarged and the algorithm become more
> complex, it becomes necessary to insert some cond_resched() calls in the
> read-ahead path.
> 
> If desktop users still feel audio jitters with the new read-ahead code,
> please try one of the following ways to get rid of it:
> 
> 1) compile kernel with CONFIG_PREEMPT_VOLUNTARY/CONFIG_PREEMPT
> 2) reduce the read-ahead request size by running
> 	blockdev --setra 256 /dev/hda # or whatever device you are using

Do you have any numbers on this (say, from Ingo's latency tracer)?  Have
you confirmed it's not a latency regression with the default settings?

Lee

