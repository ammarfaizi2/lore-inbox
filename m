Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWGHWTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWGHWTa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 18:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWGHWTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 18:19:30 -0400
Received: from tallyho.bytemark.co.uk ([80.68.81.166]:33477 "EHLO
	tallyho.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1751241AbWGHWTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 18:19:30 -0400
Date: Sat, 8 Jul 2006 23:19:24 +0100
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Ask List <askthelist@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Runnable threads on run queue
Message-ID: <20060708221923.GA1893@gallifrey>
References: <loom.20060708T220409-206@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20060708T220409-206@post.gmane.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.32 (i686)
X-Uptime: 23:16:55 up 60 days, 11:29,  2 users,  load average: 0.88, 0.71, 0.50
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ask List (askthelist@gmail.com) wrote:
> Have an issue maybe someone on this list can help with. 

<snip>

> Please help.
> 
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

Could you also post the output of iostat -x 1  covering the same period?
(You might need to restrict the set of devices if you have a lot)
The pattern of bursts of output is something I've seen on apps
just trying to do continuous large writes and I'm wondering
what you are seeing there.

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
