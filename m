Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265750AbUATUgO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 15:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265751AbUATUgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 15:36:14 -0500
Received: from SMTP1.andrew.cmu.edu ([128.2.10.81]:32727 "EHLO
	smtp1.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S265750AbUATUgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 15:36:08 -0500
Subject: 2.6.1 "clock preempt"?
From: Steinar Hauan <steinhau@andrew.cmu.edu>
Reply-To: hauan@cmu.edu
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Carnegie Mellon University
Message-Id: <1074630968.19174.49.camel@steinar.cheme.cmu.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Tue, 20 Jan 2004 15:36:08 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

  i've started to test the 2.6 series of kernels and observed a
  strange thing: with moderate background load, the system clock
  (i.e. time) seems to slow down to about 60% of normal speed
  and the normally reliable ntp process (v4.2.0)

  details: working interactively with a couple of background dummy
  processes (*1), my system clock slowed down approx 90 mins over
  a period of approx 4 hrs real time.
 
(*1) infinite loop: 1 rip, 1 encode -- both run at nice 10

  the kernel logs show messages on the form:

localhost kernel: Losing too many ticks!
localhost kernel: TSC cannot be used as a timesource.
                       (Are you running with SpeedStep?)
localhost kernel: Falling back to a sane timesource.
localhost kernel: set_rtc_mmss: can't update from 5 to 58

  without the background load, the system keeps perfect time.

==> any ideas of what could be going on would be appreciated.

  hardware details
    Intel P4 2.53gz on Supermicro P4SAA mobo (Intel 7205 chipset)
    1gb memory; multiple drives; Promise Ultra/133 raid controller
  software
    kernel 2.6.1 w/APIC and PREEMPT options turned on.
    Fedora Core 1 + selected development packages (verified on 2.4).

  more info available on request.

regards,
-- 
  Steinar Hauan, dept of ChemE  --  hauan@cmu.edu
  Carnegie Mellon University, Pittsburgh PA, USA


