Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264071AbUDBPWB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 10:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264074AbUDBPWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 10:22:00 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:48132 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S264071AbUDBPV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 10:21:58 -0500
Message-ID: <406D89B8.4090308@techsource.com>
Date: Fri, 02 Apr 2004 10:41:44 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Consistently slower 3ware RAID performance under 2.6.4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

## Background:

I'm doing a lot of sequential read and write performance tests on my 
3ware 7000-2 controller (RAID1 with 2xWD1200JB), because I'm getting 
very poor write performance.  This is a problem that I'm currently 
working with 3ware to resolve, and they are working enthusiastically 
with me to fix it.

Read test:    time dd if=/dev/sda2 of=/dev/null bs=1024k count=1024
Write test:   time dd if=/dev/zero of=/dev/sda2 bs=1024k count=1024

NOTE:  /dev/sda2 is the swap partition which is NEAR the outer-most tracks.


## The new problem I discovered specific to Linux:

Regardless of the above-mentioned problem, I am noticing a very 
significant performance drop between a 2.4 kernel and a 2.6 kernel.


## Performance with "2.4.25-gentoo":

The read test here takes 21.6 seconds which is about 47MB/sec.  This is 
a correct number, because I have measured the maximum read throughput 
from each drive to be 47MB/sec.

The write test here takes 2 minutes, 2.5 seconds.  This translates to 
8.35MB/sec.  This is what I'm working with 3ware to correct, but let's 
call this the baseline write performance.


## Performance with "2.6.4-gentoo-r1":

The read test here takes 33.9 seconds.  That's down to about 30MB/sec.

The write test here takes 2 minutes, 44.2 seconds.  That is down to 
6.2MB/sec.


## HELP?

How can I help kernel developers to diagnose this problem?  What 
information do I need to provide that is missing?

What is responsible for such a significant performance drop on LONG 
sequential disk accesses?


## My computer:

Athlon 2800+
1GB RAM  (Corsair 2700LL)
ABIT KD7 (KT400 chipset)


Thanks in advance for the help!

