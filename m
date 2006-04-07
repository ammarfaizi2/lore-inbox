Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWDGPQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWDGPQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 11:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWDGPQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 11:16:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:32966 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964797AbWDGPQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 11:16:25 -0400
X-Authenticated: #14349625
Subject: Re: [patch][rfc] quell interactive feeding frenzy
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <1144419294.14231.7.camel@homer>
References: <1144402690.7857.31.camel@homer>
	 <200604072256.27665.kernel@kolivas.org> <1144417064.8114.26.camel@homer>
	 <200604072356.03580.kernel@kolivas.org>  <1144419294.14231.7.camel@homer>
Content-Type: text/plain
Date: Fri, 07 Apr 2006 17:16:53 +0200
Message-Id: <1144423014.16622.9.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-07 at 16:14 +0200, Mike Galbraith wrote:
> On Fri, 2006-04-07 at 23:56 +1000, Con Kolivas wrote:
> > > Maybe what I did isn't the best that can be done, but something has to
> > > be done about that.  It is very b0rken under heavy load.
> > 
> > Your compromise is as good as any.

My tree with that change doing make -j100.  That change is what's
keeping it half sane.

top - 16:58:01 up 21 min,  6 users,  load average: 119.54, 96.91, 50.42

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
20902 root      22   0 20580  17m 3680 R  4.4  1.7   0:00.41 cc1
21145 root      19   0 18224  14m 3688 R  4.4  1.5   0:00.30 cc1
22287 root      17   0 12668 7872 1988 R  4.4  0.8   0:00.11 cc1
21238 root      22   0 17020  13m 3724 R  4.0  1.4   0:00.32 cc1
21116 root      22   0 18048  13m 2468 R  4.0  1.3   0:00.30 cc1
21531 root      19   0 25688  22m 3744 R  4.0  2.2   0:01.03 cc1
21608 root      19   0 22512  18m 3720 R  4.0  1.9   0:00.60 cc1
21703 root      19   0 20372  17m 3752 R  4.0  1.7   0:00.72 cc1
21711 root      19   0 23044  19m 3748 R  4.0  1.9   0:00.81 cc1
21755 root      19   0 18072  14m 3696 R  4.0  1.4   0:00.42 cc1
21759 root      19   0 18332  14m 3712 R  4.0  1.5   0:00.43 cc1
22148 root      18   0 11484 6736 1976 R  3.2  0.7   0:00.08 cc1
21913 root      18   0 10304 5300 1952 R  2.0  0.5   0:00.05 cc1
22040 root      18   0 10304 5220 1952 R  2.0  0.5   0:00.05 cc1
22063 root      18   0 10296 5416 1976 R  2.0  0.5   0:00.05 cc1
22065 root      18   0 10300 5388 1976 R  2.0  0.5   0:00.05 cc1
22122 root      18   0 10444 5448 1952 R  2.0  0.5   0:00.05 cc1
22150 root      18   0 10444 5384 1952 R  2.0  0.5   0:00.05 cc1
20771 root      19   0 21412  17m 3740 D  1.6  1.8   0:00.67 cc1


