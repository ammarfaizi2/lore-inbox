Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315472AbSFKDsY>; Mon, 10 Jun 2002 23:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316682AbSFKDsX>; Mon, 10 Jun 2002 23:48:23 -0400
Received: from [205.214.34.82] ([205.214.34.82]:65286 "EHLO mail.paxonet.com")
	by vger.kernel.org with ESMTP id <S315472AbSFKDsX>;
	Mon, 10 Jun 2002 23:48:23 -0400
Date: Mon, 10 Jun 2002 20:48:22 -0700 (PDT)
From: Simon Matthews <simon@paxonet.com>
X-X-Sender: simon@spare
To: linux-kernel@vger.kernel.org
Subject: NFS Client mis-behaviour?
Message-ID: <Pine.LNX.4.44.0206102041020.11116-100000@spare>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have seen some strange behaviour from the NFS client. 

We installed a new machine, 2 x 2.2GHz Xeon processors, based on the Intel 
E75000 chipset. Ethernet interface is an on-board Intel 8255x based. 
Kernel is 2.4.18 with the 3.5GB VM patch installed. 

When running a large job on this machine, the job would start and after a 
short time, the CPU utilization would drop and the large job would clearly 
hang. Also, "df" would hang and any attempts to list the directory that 
contained the data would hang. Eventually, after about 10-15 minutes, it 
would go back to normal (until the large job was started again).

Clearly the NFS client was unable to access the data directory.

Solution: the Ethernet interface was connected to a switch that only 
supports half-duplex connecting to a full-duplex switch solved the 
problem. However, it does seem that the NFS client was not handling the 
situation well. 

Another question: this system has 2 CPUs, yet the kernel detects 4. Any 
ideas why? 

Simon


