Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267560AbTACQF3>; Fri, 3 Jan 2003 11:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267562AbTACQF3>; Fri, 3 Jan 2003 11:05:29 -0500
Received: from navgwout.symantec.com ([198.6.49.12]:57012 "EHLO
	navgwout.symantec.com") by vger.kernel.org with ESMTP
	id <S267560AbTACQF1>; Fri, 3 Jan 2003 11:05:27 -0500
To: linux-kernel@vger.kernel.org
Subject: Gigabit/SMP performance problem
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 5.0.9a  January 7, 2002
Message-ID: <OFC4D9AF0E.DA93F4D7-ON85256CA3.0058C567-85256CA3.00592873@symantec.com>
From: "Avery Fay" <avery_fay@symantec.com>
Date: Fri, 3 Jan 2003 11:12:23 -0500
X-MIMETrack: Serialize by Router on USCU-SMTPOB01-1/GLOBE-ADMIN/SYMANTEC(Release 5.0.11
  |July 24, 2002) at 01/03/2003 08:22:15 AM,
	Serialize complete at 01/03/2003 08:22:15 AM
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm working with a dual xeon platform with 4 dual e1000 cards on different 
pci-x buses. I'm having trouble getting better performance with the second 
cpu enabled (ht disabled). With a UP kernel (redhat's 2.4.18), I can route 
about 2.9 gigabits/s at around 90% cpu utilization. With a SMP kernel 
(redhat's 2.4.18), I can route about 2.8 gigabits/s with both cpus at 
around 90% utilization. This suggests to me that the network code is 
serialized. I would expect one of two things from my understanding of the 
2.4.x networking improvements (softirqs allowing execution on more than 
one cpu):

1.) with smp I would get ~2.9 gb/s but the combined cpu utilization would 
be that of one cpu at 90%.
2.) or with smp I would get more than ~2.9 gb/s.

Has anyone been able to utilize more than one cpu with pure forwarding?

Note: I realize that I am not using a stock kernel. I was in the past, but 
I ran into the same problem (smp not improving performance), just at lower 
speeds (redhat's kernel was faster). Therefore, this problem is neither 
introduced nor solved by redhat's kernel. If anyone has suggestions for 
improvements, I can move back to a stock kernel.

Note #2: I've tried tweaking a lot of different things including binding 
irq's to specific cpus, playing around with e1000 modules settings, etc.

Thanks in advance and please CC me with any suggestions as I'm not 
subscribed to the list.

Avery Fay

P.S. Only got one response on the linux-net list so I'm posting here. One 
thing I did learn from that response is that redhat's kernel is faster 
because they use a napi version of the e1000 driver.
