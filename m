Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264364AbTLES6F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 13:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264362AbTLES4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 13:56:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:19109 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264348AbTLESzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 13:55:13 -0500
Subject: Prcess scheduler Imiprovements in 2.6.0-test9
From: Craig Thomas <craiger@osdl.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1070650522.13254.28.camel@bullpen.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 05 Dec 2003 10:55:22 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OSDL has been running peformance tests with hackbench to measure the
improvment of the scheduler, compared with LInux 2.4.18.  We ran the
test on our Scalable Test Platform on different system sizes.  The
results obtained seem to show that the 2.6 scheduler is more
efficient and allows for greater scalability on larger systems.
See http://marc.theaimsgroup.com/?l=linux-kernel&m=100805466304516&w=2
for a description of hackbench.

The set of data below shows an average time of five hackbench runs
for each set of groups.  Linux 2.6.0-test9 clearly shows significan
improvement in the completion times.

Test set 1: Performance of hackbench

(times are in seconds, lower number is better)

number of groups     50     100     150     200
--------------------------------------------------
1 CPU
   2.4.18          15.52   37.63   74.34   110.62
   2.6.0-test9      9.91   17.86   27.55    39.77
--------------------------------------------------
2 CPUs
   2.4.18          10.50   30.42   64.26   112.46
   2.6.0-test9      7.44   13.45   19.68    26.68
--------------------------------------------------
4 CPUs
   2.4.18           7.07   22.75   54.10   101.45
   2.6.0-test9      5.16   9.25    13.64    18.65
--------------------------------------------------
8 CPUs
   2.4.18           7.02   24.63   61.48   114.93
   2.6.0-test9      4.08   7.15    10.31    13.84
--------------------------------------------------

The set of data below shows how many groups can be run before the
system failed with some resouce limitiation having been exceeded.
The kernel was not tuned, so this tests a defalut configuration.

Test set 2: Max Groups Before Out of Resource
(maximum nuber of groups that completed a successful run;  larger
numbers are better)

------------------------
1 CPU
   2.4.18           200
   2.6.0-test9      200
------------------------
2 CPUs
   2.4.18           225
   2.6.0-test9      350
------------------------
4 CPUs
   2.4.18           225
   2.6.0-test9      525
------------------------
8 CPUs
   2.4.18           225
   2.6.0-test9      425
------------------------

We have been running hackbench results up through 2.6.0-test11 and
we see no significant differences between test-11 and test9, so these
results should be valid for test-11 as well.

A write-up of these results (complete with graphical plots) is posted
at  http://developer.osdl.org/craiger/hackbench/index.html

-- 
Craig Thomas
craiger@osdl.org

