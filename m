Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265119AbTL2WH4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 17:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265126AbTL2WH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 17:07:56 -0500
Received: from [24.35.117.106] ([24.35.117.106]:37513 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265119AbTL2WHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 17:07:52 -0500
Date: Mon, 29 Dec 2003 17:07:46 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.0 performance problems
Message-ID: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I spend almost all of my time using, testing, and hacking on development 
kernels.  On my laptop I have noticed that things seemed to take an 
inordinate amount of time to complete.  I've ascribed most of this to the 
fact that most of the systems I work on have decent system specifications 
while my laptop is a PIII 650 MHz processor.  

I just finished a couple of comparisons between 2.4 and 2.6 which seem to 
confirm my impressions.  I understand that the comparison may not be 
apples to apples and my methods of testing may not be rigorous, but here 
it is.  In contrast to some recent discussions on this list, this test is 
a "real world" test at which 2.6 comes off much worse than 2.4.  

The 2.4 kernel I used for this test is the standard RedHat kernel in 
Fedora Core 1, 2.4.22-1.2129.nptl.  The 2.6 kernel is the latest bk pull 
from today.  The test was doing a bk export from a freshly updated bk 
repository.  The specific command was:
bk export linux-2.5 linux-2.6-tm

Under 2.4 top shows: 

user	nice	system	irq	softirq	iowait	idle
1.3	0	2.1	0	0	0	96.6

Execution time for the test was:
real	13m33.482s
user	0m33.540s
sys	0m16.210s


Under 2.6 top shows:
user	nice	system	irq	softirq	iowait	idle
0.9	0	5.3	0.9	0.3	92.6	0

Execution time for the test was:
real	22m42.397s
user	0m37.753s
sys	0m54.043s

I've done no performance tweaking in either case.  Both tests were done 
immediately after boot up with only the top program running in each case.  
I'm not sure what other data would be relevant here.  Any thoughts from 
the group would be appreciated.
