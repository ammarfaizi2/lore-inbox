Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262479AbSJWBw4>; Tue, 22 Oct 2002 21:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262568AbSJWBw4>; Tue, 22 Oct 2002 21:52:56 -0400
Received: from web21501.mail.yahoo.com ([66.163.169.12]:32935 "HELO
	web21501.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262479AbSJWBw4>; Tue, 22 Oct 2002 21:52:56 -0400
Message-ID: <20021023015905.63415.qmail@web21501.mail.yahoo.com>
Date: Tue, 22 Oct 2002 18:59:05 -0700 (PDT)
From: Lk Overrun <lkoverrun@yahoo.com>
Subject: Brust data send problem on gigabit NIC on Linux
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I am seeking advice on how to best send out huge
number of packets on a gigabit ethernet interface.  I
am using kernel 2.4.19.  I try to send out as many as
possible 15Kbyte-long ethernet packets to try to
utilize the giga-bit/sec bandwidth.  My CPU is really
fast (2 GHz) amd I dump the packets to the interface
in a  tight loop in user space.  However, I can only
reach around 400 Mbits/sec before the packets get
dropped.  The queue discipline (qdisc) seems to be
responsible because the queue length (txqueuelen) is
only 100 by default, and the queue just cannot store
so many packets at once.  I can eliminate the packet
drop by raising the queue length to somewhere like
60000 but that is not practical because it uses too
much memory. It seems I need some delay between
sending packets but I cannot sleep for less than 10 ms
(1/Hz) in user space and 10 ms is too long.

I am using raw socket bypassing the IP stack and my
NIC is the Intel Pro1000 (using the e1000.o driver).

What is the best way to send raw ethernet packets,
reaching gigabit range withuut packet drop on Linux? 
Thanks for any advice.

 

__________________________________________________
Do you Yahoo!?
Y! Web Hosting - Let the expert host your web site
http://webhosting.yahoo.com/
