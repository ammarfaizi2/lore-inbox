Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbUA2Jjo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 04:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264471AbUA2Jjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 04:39:44 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:45330 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S261506AbUA2Jjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 04:39:43 -0500
From: Jos Hulzink <josh@stack.nl>
To: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.1 Hyperthread smart "nice"
Date: Thu, 29 Jan 2004 10:39:22 +0100
User-Agent: KMail/1.5.3
References: <200401291917.42087.kernel@kolivas.org>
In-Reply-To: <200401291917.42087.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401291039.22561.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 Jan 2004 09:17, Con Kolivas wrote:
> Hi all
>
> This patch (together with the ht base patch) will not allow a priority >10
> difference to run concurrently on both siblings, instead putting the low
> priority one to sleep. Overall if you run concurrent nice 0 and nice 20
> tasks with this patch your cpu throughput will drop during heavy periods by
> up to 10% (the hyperthread benefit), but your nice 0 task will run about
> 90% faster. It has no effect if you don't run any tasks at different "nice"
> levels. It does not modify real time tasks or kernel threads, and will
> allow niced tasks to run while a high priority kernel thread is running on
> the sibling cpu.

If I read you correctly, if one thread has nothing else to do but the nice 0 
task, the nice 20 task will never be scheduled at all ? Sounds like not the 
perfect solution to me...

Jos

