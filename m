Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261339AbTCOCzm>; Fri, 14 Mar 2003 21:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261341AbTCOCzm>; Fri, 14 Mar 2003 21:55:42 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:24207 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261339AbTCOCzk>; Fri, 14 Mar 2003 21:55:40 -0500
Date: Fri, 14 Mar 2003 18:56:37 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alex Tomas <bzzz@tmi.comex.ru>,
       linux-kernel <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@digeo.com>, anton@samba.org
Subject: Re: [PATCH] concurrent block allocation for ext3
Message-ID: <251250000.1047696997@flay>
In-Reply-To: <227420000.1047676948@flay>
References: <m3zno3grfz.fsf@lexa.home.net> <227420000.1047676948@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> SDET on my machine (16x NUMA-Q) has fallen in love with your patch, 
> and has decided to elope with it to a small desert island. This is 
> despite it's one disk hung off node 0, and the IO througput of a 
> slightly damp piece of cotton thread. Apologies for the loss of your 
> patch as it gets whisked away ;-)

Dbench (1 disk, x440 8 real cpus, 16 HT ones)

before: 
Throughput 265.032 MB/sec (NB=331.29 MB/sec  2650.32 MBit/sec)  256 procs
after:
Throughput 381.964 MB/sec (NB=477.454 MB/sec  3819.64 MBit/sec)  256 procs

(I took the second run, first ones are slower, seems to be stable after)

NUMA-Q 16-way (1 disk. 16 cpus)

before:
Throughput 48.5304 MB/sec (NB=60.663 MB/sec  485.304 MBit/sec)  256 procs
after:
Throughput 58.8483 MB/sec (NB=73.5603 MB/sec  588.483 MBit/sec)  256 procs

NUMA-Q has slower disks, old adaptors, and a slow cross-node interconnect.

