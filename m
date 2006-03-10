Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbWCJNgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWCJNgi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 08:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWCJNgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 08:36:38 -0500
Received: from networks.syneticon.net ([213.239.212.131]:37537 "EHLO
	mail2.syneticon.net") by vger.kernel.org with ESMTP
	id S1751008AbWCJNgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 08:36:37 -0500
Message-ID: <441180DD.3020206@wpkg.org>
Date: Fri, 10 Mar 2006 14:36:29 +0100
From: Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Mail/News 1.5 (X11/20060225)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: can I bring Linux down by running "renice -20 cpu_intensive_process"?
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Linux server (kernel 2.6.8.1 + Linux RAID1) which is a "backup" 
machine: it gets the files from other servers, compresses it, writes to 
the tape, checks md5sums etc.

It's been running for quite a bit, no problems with stability so far.

Yesterday, something happened though.

I was logged in remotely, and the system was running md5sum against a 30 
GB file.

I wanted the things to speed up a bit, and made "renice -20 <md5sum_pid>".

Few minutes after that I couldn't start any process, so I thought I made 
the system so busy with renice -20, that my SSH session probably 
disconnected.

In the morning, the system was still unavailable - I could ping it, I 
could telnet to any of the ports opened, but nothing more happened.

SSH was waiting forever after:

debug1: identity file /root/.ssh/identity type -1
debug1: identity file /root/.ssh/id_rsa type -1
debug1: identity file /root/.ssh/id_dsa type -1


Nothing was displayed on the monitor (all black).

As I restarted the machine, I saw that the logging ends few minutes 
after I changed the priority of md5sum to -20.


So here is my question: is it possible to bring down the machine by 
simply doing "renice -20 cpu_intensive_process"?

As I said, this machine does heavy compression and md5sum calculations 
of big files every day, and was stable all the time - but stopped 
responding after I changed the priority of a CPU-intensive process to -20.

Coincidence and a hardware failure?

-- 
Tomasz Chmielewski
http://wpkg.org
