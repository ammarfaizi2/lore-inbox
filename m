Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272219AbRIKAUl>; Mon, 10 Sep 2001 20:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272214AbRIKAUb>; Mon, 10 Sep 2001 20:20:31 -0400
Received: from are.twiddle.net ([64.81.246.98]:33930 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S272219AbRIKAUU>;
	Mon, 10 Sep 2001 20:20:20 -0400
Date: Mon, 10 Sep 2001 17:19:33 -0700
From: Richard Henderson <rth@twiddle.net>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: 2.4.10-pre6 fd_install BUG
Message-ID: <20010910171933.A5663@twiddle.net>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just gotten 3 of these while building gcc (UP ev67):

  kernel BUG at /home/rth/work/linux/linux/include/linux/file.h:93!
  sh(19121): Kernel Bug 1
  [Oops report]
  Call trace:
	fffffc000085421c	do_pipe+2ac
	fffffc000081313c	sys_pipe

Given that we've called get_unused_fd, it seems highly suspect
that we'd have a descriptor installed already.  

Is anyone else seeing this, or should I start looking for compiler bugs?


r~
