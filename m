Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161110AbWGIHOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161110AbWGIHOx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 03:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWGIHOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 03:14:53 -0400
Received: from mail.gmx.de ([213.165.64.21]:31105 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932375AbWGIHOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 03:14:52 -0400
X-Authenticated: #14349625
Subject: Re: Runnable threads on run queue
From: Mike Galbraith <efault@gmx.de>
To: Ask List <askthelist@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <loom.20060708T220409-206@post.gmane.org>
References: <loom.20060708T220409-206@post.gmane.org>
Content-Type: text/plain
Date: Sun, 09 Jul 2006 09:20:26 +0200
Message-Id: <1152429626.9711.34.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 20:18 +0000, Ask List wrote:
> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
> 83  0   1328 301684  37868 1520632    0    0     0   264  400  1332 98  2  0  0
> 17  0   1328 293936  37868 1520688    0    0     0     0  537   979 97  3  0  0
> 73  0   1328 293688  37868 1520712    0    0     0     0  268  2643 98  2  0  0
> 80  0   1328 277220  37868 1520756    0    0     0     0  351   824 98  2  0  0
> 49  0   1328 262452  37868 1520800    0    0     0     0  393  1882 97  3  0  0
> 45  0   1328 246796  37868 1520828    0    0     0   304  302  1631 96  4  0  0
> 55  0   1328 243852  37868 1520872    0    0     0     0  356  1101 99  1  0  0
> 17  0   1328 228672  37868 1520916    0    0     0     0  336   748 97  3  0  0
>  0  0   1328 299948  37868 1520956    0    0     0     0  299   821 78  3 19  0
>  0  0   1328 299184  37868 1520960    0    0     0     0  168    78  8  0 92  0
>  0  0   1328 299184  37868 1520960    0    0     0   248  173    38  0  1 99  0
>  0  0   1328 299184  37868 1520960    0    0     0     0  160    20  0  0 100  0
>  0  0   1328 299184  37868 1520960    0    0     0     0  151     6  0  0 100  0
>  0  0   1328 299184  37868 1520960    0    0     0     0  162    42  0  1 99  0
>  1  0   1328 299188  37868 1520960    0    0     0     0  161    24  0  0 100  0
>  0  0   1328 298808  37868 1520988    0    0     0   100  303  1119 57  0 42  0
>  0  0   1328 298808  37868 1520988    0    0     0     0  162    22  0  1 99  0

Looking at the interrupts column, I suspect you have a network problem,
not a scheduler problem.  Looks to me like your SpamAssasins are simply
running out of work to do because your network traffic comes in bursts.

	-Mike

