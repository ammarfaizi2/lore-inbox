Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130049AbRBWLFn>; Fri, 23 Feb 2001 06:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131495AbRBWLFd>; Fri, 23 Feb 2001 06:05:33 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:12026 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S130049AbRBWLF0>;
	Fri, 23 Feb 2001 06:05:26 -0500
Date: Fri, 23 Feb 2001 16:36:00 +0530
From: Dipankar Sarma <dipankar@sequent.com>
To: lse-tech@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Read-Copy Update mutual exclusion for linux
Message-ID: <20010223163600.B26060@in.ibm.com>
Reply-To: dipankar@sequent.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Read-Copy Update is a two-phase mutual exclusion method that can be
used to avoid overhead and code complexity of conventional methods
that use spin-waiting. It uses the event-driven nature of operating
systems to defer exceptional conditions until currently active code
has completed allowing common code paths to proceed without delay.
This technique is potentially useful for maintenance of read-mostly
data structures and unusual situations like module unloading.

An implementation of this based on the original DYNIX/ptx implementation 
is now available for Linux (2.4.1 kernel) at 
http://lse.sourceforge.net/locking/rclock.html.

Thanks
Dipankar

-- 
Dipankar Sarma  (dipankar@sequent.com)
IBM Linux Technology Center
IBM India Software Lab, Bangalore, India.
