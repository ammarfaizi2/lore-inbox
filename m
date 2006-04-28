Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030422AbWD1O4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030422AbWD1O4J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 10:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030426AbWD1O4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 10:56:09 -0400
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:23211 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030422AbWD1O4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 10:56:08 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Hirokazu Takahashi <taka@valinux.co.jp>
Subject: Re: [ckrm-tech] Re: [PATCH 0/9] CPU controller
Date: Sat, 29 Apr 2006 00:55:27 +1000
User-Agent: KMail/1.9.1
Cc: maeda.naoaki@jp.fujitsu.com, linux-kernel@vger.kernel.org, efault@gmx.de,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net
References: <200604282011.36917.kernel@kolivas.org> <200604282309.32320.kernel@kolivas.org> <20060428.225541.124090656.taka@valinux.co.jp>
In-Reply-To: <20060428.225541.124090656.taka@valinux.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604290055.27919.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 April 2006 23:55, Hirokazu Takahashi wrote:
> I think you can introduce some threshold to estimate whether
> a process should be treated as an interactive process or not
> while vanilla kernel defines it statically.

The static definition (TASK_INTERACTIVE) used is based on what the cpu 
scheduler already knows about the tasks so although it's static, it is based 
on the dynamic behaviour and most recent sleep/run data. Unfortunately we 
can't define it any clearer than that. We have no better metric that states 
clearly that anything is definitely interactive. Thus there is no clearly 
defined threshold we can use either. If it was that simple the estimator 
would be simpler and we wouldn't have half a dozen alternative cpu schedulers 
available all looking to tackle much the same thing.

-- 
-ck
