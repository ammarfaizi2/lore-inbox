Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbWEZKlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWEZKlf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 06:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWEZKle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 06:41:34 -0400
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:65477 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751382AbWEZKle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 06:41:34 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [RFC 0/5] sched: Add CPU rate caps
Date: Fri, 26 May 2006 20:41:07 +1000
User-Agent: KMail/1.9.1
Cc: Mike Galbraith <efault@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>
In-Reply-To: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605262041.09221.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 May 2006 14:20, Peter Williams wrote:
> These patches implement CPU usage rate limits for tasks.

Nice :)

> Although the rlimit mechanism already has a CPU usage limit (RLIMIT_CPU)
> it is a total usage limit and therefore (to my mind) not very useful.
> These patches provide an alternative whereby the (recent) average CPU
> usage rate of a task can be limited to a (per task) specified proportion
> of a single CPU's capacity.  The limits are specified in parts per
> thousand and come in two varieties -- hard and soft.

Why 1000? I doubt that degree of accuracy is possible in cpu accounting and 
accuracy or even required. To me it would seem to make more sense to just be 
a percentage.

-- 
-ck
