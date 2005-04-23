Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVDWRf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVDWRf1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 13:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVDWRf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 13:35:27 -0400
Received: from pythagoras.zen.co.uk ([212.23.3.140]:11475 "EHLO
	pythagoras.zen.co.uk") by vger.kernel.org with ESMTP
	id S261629AbVDWRfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 13:35:22 -0400
Date: Sat, 23 Apr 2005 18:35:14 +0100
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: linux-kernel@vger.kernel.org
Subject: Hotplug CPU and setaffinity?
Message-ID: <20050423173514.GA7111@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.10-5-k7-smp (i686)
X-Uptime: 18:31:14 up  6:27,  1 user,  load average: 0.03, 0.06, 0.08
User-Agent: Mutt/1.5.6+20040907i
X-Originating-Pythagoras-IP: [212.23.14.246]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I got to wondering how Hotplug CPU and sched_setaffinity interact;
if I have a process that has its affinity set to one CPU and some
nasty person comes along and unplugs it what happens to that process-
does it get scheduled onto another cpu, just not get any time or
die ?

In particular I was thinking of the cases where a thread has a
 functional reason for remaining on one particular CPU (e.g. if you
had calibrated for some feature of that CPU say its time stamp
counter skew/speed). Another case would be a set of threads which
had set their affinity to the same CPU and then made memory
consistency or locking assumptions that wouldn't be valid
if they got rescheduled onto different CPUs.

Dave

 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
