Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283702AbRK3TbB>; Fri, 30 Nov 2001 14:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283705AbRK3Tav>; Fri, 30 Nov 2001 14:30:51 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:46483 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S280983AbRK3Tag>; Fri, 30 Nov 2001 14:30:36 -0500
Message-Id: <200111301930.fAUJUU404171@eng4.beaverton.ibm.com>
To: "BALBIR SINGH" <balbir.singh@wipro.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from drivers' release functions 
In-Reply-To: Your message of "Thu, 29 Nov 2001 19:25:55 +0530."
             <3C063E6B.5060308@wipro.com> 
Date: Fri, 30 Nov 2001 11:30:30 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Even register_blkdev(), etc hold BKL, without these there will be
    a lot of problems, all these need to be taken care of if BKL is
    ever replaced.

I think it's pretty clear that the BKL has become so, um, multi-functional
over the years that any replacement will not involve a single new variable
(or algorithm).  On the plus side, it also means it can be a stepwise
project. If we carefully identify each function and replace it or obsolete
it, we can gradually deprecate the BKL at a safe and sane pace.

Everybody keep track of these usages; there will come a day where somebody
is asking you about it again :) open/release is the tip of the iceberg,
but it takes a long time for an iceberg to melt ....

Rick
