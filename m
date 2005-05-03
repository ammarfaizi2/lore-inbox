Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVECUqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVECUqF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 16:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVECUqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 16:46:05 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:12961 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261687AbVECUp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 16:45:59 -0400
Subject: Re: question about contest benchmark
From: Lee Revell <rlrevell@joe-job.com>
To: Valdis.Kletnieks@vt.edu
Cc: Haoqiang Zheng <haoqiang@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200505032009.j43K9qQJ023179@turing-police.cc.vt.edu>
References: <d6e6e6dd05050311115d256213@mail.gmail.com>
	 <1115144999.29445.7.camel@mindpipe>
	 <200505032009.j43K9qQJ023179@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Tue, 03 May 2005 16:45:57 -0400
Message-Id: <1115153157.29619.33.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-03 at 16:09 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 03 May 2005 14:29:59 EDT, Lee Revell said:
> 
> > But, it seems to me that even if an interactive process briefly goes CPU
> > bound (due to bloat, bugs, or intent), it should still be scheduled
> > preferentially to a pure CPU bound process like a build.
> 
> So you want it to schedule that big image (Evolution) that's already used 5
> minutes of CPU since it started (this morning, admittedly) in preference to
> that cc1 process that will be gone before it's used 2 seconds of CPU, plus all
> the disk I/O that cc1 performs (hopefully the cache will help here, but it may
> indeed go to disk to read the source files)?
> 

Yes.  Almost no one will notice whether that build took 2 or 4 seconds.
But a few seconds is an eternity when you are staring at a blank pane,
waiting for it to render the message list.  And I found that when
waiting for the message list to render, backgrounding the build causes
it to render in a second or two, while if I just wait for it it might
take 20 seconds.  This implies that the scheduler could do the same
thing.

Anyway, this was not a great example, as the problem turned out to be an
application bug.  If I can find a non-pathological case that
demonstrates a scheduler problem, I'll post it.

Lee

