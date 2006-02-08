Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030574AbWBHHoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030574AbWBHHoF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030578AbWBHHoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:44:05 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:63941 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030574AbWBHHoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:44:04 -0500
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
From: Lee Revell <rlrevell@joe-job.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: gcoady@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <200602081400.59931.kernel@kolivas.org>
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com>
	 <200602081335.18256.kernel@kolivas.org>
	 <24niu1hrom6udfa2km18b8bagad62kjamc@4ax.com>
	 <200602081400.59931.kernel@kolivas.org>
Content-Type: text/plain
Date: Wed, 08 Feb 2006 02:43:58 -0500
Message-Id: <1139384639.9244.96.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-08 at 14:00 +1100, Con Kolivas wrote:
> This is the terminal's fault. xterm et al use an algorithm to
> determine how fast your machine is and decide whether to jump scroll
> or smooth scroll. This algorithm is basically broken with the 2.6
> scheduler and it decides to mostly smooth scroll.
> 

Hmm, I've been having a similar problem for ages.  If I just do "ls" in
my home directory 10 or 20 times, approximately 20% of the time it's
"fast":

real    0m0.177s
user    0m0.028s
sys     0m0.027s

And the rest of the times it's "slow":

real    0m1.240s
user    0m0.036s
sys     0m0.040s

I rarely get anything in between - it's either ~1.2s or ~0.2s.

"time ls | cat" is always fast - 0.18 - 0.35s.

real    0m0.188s
user    0m0.014s
sys     0m0.018s

It has been this way as long as I can remember and it never made
sense...

Lee

