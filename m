Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbTK3TTI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 14:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbTK3TTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 14:19:08 -0500
Received: from m17.lax.untd.com ([64.136.30.80]:8886 "HELO m17.lax.untd.com")
	by vger.kernel.org with SMTP id S263024AbTK3TS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 14:18:59 -0500
To: linux-kernel@vger.kernel.org
Date: Sun, 30 Nov 2003 08:57:26 -0800
Subject: Oops with tmpfs on both 2.4.22 & 2.6.0-test11
Message-ID: <20031130.085729.-1591395.1.mcmechanjw@juno.com>
X-Mailer: Juno 5.0.33
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Juno-Line-Breaks: 0-10,12-20
From: James W McMechan <mcmechanjw@juno.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a test program much shorter then the Oops
If someone wants to work from a Oops I will send
one, no maintainer was listed and the last Google
reference is about 2 years back, and it does not
seem to be about this issue.

This Oops both 2.4.22 and 2.6.0-test11
It results from a ARCH=um bugreport and
I kept making the test program shorter
This seems silly but one line to Oops?

/* by James_McMechan at hotmail com */                                   
      
/* test2 program to Oops shmfs mounted at /dev/shm */
/* yes it is dumb but unprivileged users should not be able */
/* to Oops the kernel regardless of how dumb the program */
#include <sys/types.h>
#include <dirent.h>
main()
{/* off 0 is "." off 1 is ".." off 2 is empty */
        seekdir(opendir("/dev/shm"), (off_t) 2);
}

________________________________________________________________
The best thing to hit the internet in years - Juno SpeedBand!
Surf the web up to FIVE TIMES FASTER!
Only $14.95/ month - visit www.juno.com to sign up today!
