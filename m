Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265098AbTARWHG>; Sat, 18 Jan 2003 17:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265099AbTARWHG>; Sat, 18 Jan 2003 17:07:06 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:32503 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265098AbTARWHF>; Sat, 18 Jan 2003 17:07:05 -0500
Message-ID: <004801c2bf4f$9e9239e0$29060e09@andrewhcsltgw8>
From: "Andrew Theurer" <habanero@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: "Christoph Hellwig" <hch@infradead.org>, "Robert Love" <rml@tech9.net>,
       "Michael Hohnbaum" <hohnbaum@us.ibm.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "lse-tech" <lse-tech@lists.sourceforge.net>,
       "Erich Focht" <efocht@ess.nec.de>, "Ingo Molnar" <mingo@elte.hu>
References: <Pine.LNX.4.44.0301171607510.10244-100000@localhost.localdomain> <270920000.1042822723@titus> <550960000.1042923260@titus> <559200000.1042925659@titus>
Subject: Re: [Lse-tech] NUMA sched -> pooling scheduler (inc HT)
Date: Sat, 18 Jan 2003 16:13:37 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks Martin, I'll take a look.  One thing I have noticed on B0 numa_sched:
I added node load to /proc/stat and see a problem.  look at procs_running
compared to the total of node1..4.  They do not agree.  It looks as if the
node load and runqueue lengths may have gotten out of sync.  I could not
find any obvious place this happened.

cpu  65922 0 4321 650621 560
cpu0 5066 0 665 84545 4
cpu1 21965 0 1402 66796 0
cpu2 26187 0 1553 62290 132
cpu3 12535 0 550 77043 34
cpu4 121 0 116 89581 344
cpu5 38 0 16 90071 36
cpu6 6 0 12 90136 7
cpu7 2 0 4 90156 0
intr 909780 902661 16 0 1 1 0 5 1 0 1 1 1 60 0 10 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0
0 0 0 0 0 0 0 0 0 0 0 4274 2748 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
ctxt 32127
btime 1042925625
processes 982
procs_running 1
procs_blocked 0
node0 1
node1 1
node2 0
node3 0



