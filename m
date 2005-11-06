Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbVKFO03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbVKFO03 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 09:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbVKFO03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 09:26:29 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:5604 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1750805AbVKFO02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 09:26:28 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: erezz@techunix.technion.ac.il
Subject: Re: CPU utilization and hyperthreading
Date: Sun, 6 Nov 2005 16:26:13 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <1131286439.436e0fa79e228@webmail.technion.ac.il>
In-Reply-To: <1131286439.436e0fa79e228@webmail.technion.ac.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1255"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511061626.13578.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 November 2005 16:13, erezz@techunix.technion.ac.il wrote:
> Hi,
> 
> I'm using a 2.6.4-52 (Suse 9.1 pro distribution) kernel on a 3.2 dual
> XEON machine (with hyperthreading).
> 
> I'm trying to analyze the performance of a kernel module that contains
> 4 kernel threads (3 of them are more active). Also, some of the work is
> done in a tasklet. The CPU load (as shown in vmstat) doesn't reach more
> than 50%.  When trying to artificially stress the system with some
> useless loops, the CPU load reaches 65% (but I cannot reach 100%). Also, the
> interrupts count in vmstat is around 20000 (1000 when idle).
>  
> My questions are:
> 1. Why can't I reach 100%? 

You can.

# while true; do true; done &
# while true; do true; done &
# while true; do true; done &
# while true; do true; done &

> 2. I guess that since I have 4 virtual CPUs (as shown in /proc/cpuinfo), not all
> of them are stressed. Is there a way to see the CPU utilization for each CPU
> (vmstat doesn't allow that)? 

top

> 3. When I load a module with a kernel thread that runs an infinite loop, I get
> 25% CPU utilization (50% if I run 2 threads). Is it because I'm using 100% of a
> single CPU (out of 4)?
> 4. How is the time spent in interrupt context estimated? Is it possible to view
> it somehow?
--
vda
