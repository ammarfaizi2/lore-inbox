Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268702AbRHGErM>; Tue, 7 Aug 2001 00:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270068AbRHGErC>; Tue, 7 Aug 2001 00:47:02 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:37264 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S268702AbRHGEqu>; Tue, 7 Aug 2001 00:46:50 -0400
From: mdaljeet@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org
Message-ID: <CA256AA1.0019E765.00@d73mta01.au.ibm.com>
Date: Tue, 7 Aug 2001 10:10:05 +0530
Subject: floating point exception problem on apple PPC
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using SuSE Linux 7.1 with kernel version 2.4.2 on Apple G4 dual
processor PPC machine.

Due to setting of MSR[FE0] and MSR[FE1] bits in the 'FPUnavailable'
exception handler, a user application that tries to do floating point
arthemetic with large floating point values gets a SIGFPE signal. By
setting the FPSCR register with appropriate value in the SIGFPE signal
handler the program runs fine with the expected values.

Now, what happens is that when I run such program (that does floating point
arthemetic with large floating point values) continuously for hours, the
other applications running on the system sometimes get terminated after
receiving a SIGFPE signal while my floating point program runs fine. Is
that due to some kernel problem or loading the FPSCR in the SIGFPE signal
handler of a process can lead to this problem?

regards,
Daljeet.


