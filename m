Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277273AbRJJP32>; Wed, 10 Oct 2001 11:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277276AbRJJP3U>; Wed, 10 Oct 2001 11:29:20 -0400
Received: from mail2.megatrends.com ([155.229.80.11]:57105 "EHLO
	mail2.megatrends.com") by vger.kernel.org with ESMTP
	id <S277273AbRJJP3L>; Wed, 10 Oct 2001 11:29:11 -0400
Message-ID: <1355693A51C0D211B55A00105ACCFE6402B9E013@ATL_MS1>
From: Venkatesh Ramamurthy <Venkateshr@ami.com>
To: "'adilger@turbolabs.com'" <adilger@turbolabs.com>,
        "'xuan--lkml@baldauf.org'" <xuan--lkml@baldauf.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: dynamic swap prioritizing
Date: Wed, 10 Oct 2001 11:23:44 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If this is to be generally useful, it would be good to find things
> like max sequential read speed, max sequential write speed, and max
> seek time (at least). Estimates for max sequential read speed and
> seek time could be found at boot time for each disk relatively
> easily, but write speed may have to be found only at runtime (or
> it could all be fed in to the kernel from user space from benchmarks
> run previously).

Maybe we can find out the statistics for the first time (or when swap is
created) and store this information in the swap partition itself. This would
allow us to compute time consuming statistics only once. Also we need to
create new fields in the swap structure for this purpose.


