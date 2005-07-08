Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262618AbVGHFln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbVGHFln (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 01:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVGHFlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 01:41:42 -0400
Received: from mx2.elte.hu ([157.181.151.9]:29903 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262618AbVGHFlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 01:41:32 -0400
Date: Fri, 8 Jul 2005 07:41:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Chuck Harding <charding@llnl.gov>
Cc: Linux Kernel Discussion List <linux-kernel@vger.kernel.org>
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.51-12
Message-ID: <20050708054129.GA26208@elte.hu>
References: <20050703140432.GA19074@elte.hu> <20050703181229.GA32741@elte.hu> <Pine.LNX.4.58.0507051155050.13165@echo.lysdexia.org> <20050706100451.GA7336@elte.hu> <Pine.LNX.4.58.0507071047540.12711@localhost.localdomain> <20050707153103.GA22782@elte.hu> <Pine.LNX.4.58.0507071139220.12711@localhost.localdomain> <Pine.LNX.4.58.0507071205080.12711@localhost.localdomain> <20050707175115.GA28772@elte.hu> <Pine.LNX.4.63.0507071402410.6952@ghostwheel.llnl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0507071402410.6952@ghostwheel.llnl.gov>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chuck Harding <charding@llnl.gov> wrote:

> Which still exhibits the lockup of sox. I built a 2.6.12 vanilla kernel
> using the same .config as I used for 51-12 and the failure did not happen.
> just the process of booting up causes later invocations of sox to lockup
> in the D state. If I don't login to X and just run from a VT I can get
> it to lockup by running something like:
> $ for ((i=0;i<20;i++))
> >do
> >echo -ne "\r$i  "
> >(play /usr/share/sounds/KDE_Beep_ShortBeep.wav &)
> >done
> 
> after about 14 or so iterations of the loop and thereafter no more 
> sound can be played.

tried it and cannot reproduce it, so i'll need the full backtrace of all 
tasks in your system, whenever sox gets stuck, via:

  echo t > /proc/sysrq-trigger
  dmesg -s 10000000 > toingo.txt

	Ingo
