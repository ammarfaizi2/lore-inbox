Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbTJRLvr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 07:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbTJRLuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 07:50:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2534 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261582AbTJRLuu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 07:50:50 -0400
Date: Sat, 18 Oct 2003 12:50:49 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Software RAID5 with 2.6.0-test
Message-ID: <20031018115049.GB760@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.0-test6 (i686)
X-Uptime: 12:46:23 up  1:48,  1 user,  load average: 0.37, 0.40, 0.43
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  First off, I am never going to try building a software IDE RAID 5
on Linux again in an important production system - my experience
says that it just isn't possible to get that many IDE channels
to work together reliably.  I know there are some people who
have managed it, and I did hear there was a race condition
and a patch to fix it - but in the end in a production system
with a serious size of RAID throwing in a 3-ware or similar
is a hell of a lot simpler and just works.

  As for speed; well I'm not sure.  I think the comparisons of
100MHz processors vs the speed of your xeon are bogus.  I would
hope at least some of the work on the hardware raid controllers
is done in hardware (XORing blocks of data isn't exactly hard
in hardware), and in addition the amount of CPU used is going
to be limited by memory bandwidth (and associated cache pollution?)
before the clock rate of the processor gets involved I would
have thought.

  I'd love to see some real benchmarks to prove me wrong however!

Dave

 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
