Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266622AbTCAMho>; Sat, 1 Mar 2003 07:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268304AbTCAMho>; Sat, 1 Mar 2003 07:37:44 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:20394 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S266622AbTCAMhn>; Sat, 1 Mar 2003 07:37:43 -0500
Message-ID: <20030301124759.10054.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>, ciarrocchi@linuxmail.org,
       linux-kernel@vger.kernel.org
Cc: akpm@digeo.com
Date: Sat, 01 Mar 2003 20:47:59 +0800
Subject: Re: [BENCHMARK] AIM9 results. 2.4.19 vs 2.5.58 vs 2.5.63
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Martin J. Bligh" <mbligh@aracnet.com>
Date: Thu, 27 Feb 2003 14:16:16 -0800
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] AIM9 results. 2.4.19 vs 2.5.58 vs 2.5.63

[...]
> Could you compare 63 mainline to -mjb or -mm with objrmap patches in?
> I think you'll get significant improvements on the tests above.

Of course I can.
And here it goes the results:
2.4.19
2.5.63
2.5.63-mjb2


creat-clo 10040 19.4223        19422.31 File Creations and Closes/second
creat-clo 10010 84.3157        84315.68 File Creations and Closes/second
creat-clo 10000 87.4        87400.00 File Creations and Closes/second
^^^mjb2 is faster than 2.5.63


brk_test 10010 48.951       832167.83 System Memory Allocations/second
brk_test 10020 41.018       697305.39 System Memory Allocations/second
brk_test 10000 41.3       702100.00 System Memory Allocations/second
^^^Still slower than 2.4.19


signal_test 10000 166.1       166100.00 Signal Traps/second
signal_test 10000 148.3       148300.00 Signal Traps/second
signal_test 10010 151.748       151748.25 Signal Traps/second
^^^Still slower than 2.4.19

exec_test 10000 13.8           69.00 Program Loads/second
exec_test 10020 12.7745           63.87 Program Loads/second
exec_test 10010 12.987           64.94 Program Loads/second
^^^Still slower than 2.4.19

fork_test 10000 44.8         4480.00 Task Creations/second
fork_test 10000 23.2         2320.00 Task Creations/second
fork_test 10020 30.0399         3003.99 Task Creations/second
^^^mjb2 is faster than 2.5.63

link_test 10000 155.3         9783.90 Link/Unlink Pairs/second
link_test 10010 160.739        10126.57 Link/Unlink Pairs/second
link_test 10010 150.25         9465.73 Link/Unlink Pairs/second
^^^mmh... strange


array_rtns 10010 13.6863          273.73 Linear Systems Solved/second
array_rtns 10020 11.2774          225.55 Linear Systems Solved/second
array_rtns 10050 13.5323          270.65 Linear Systems Solved/second
^^^^^^mjb2 is faster than 2.5.63

mem_rtns_1 10000 27.7       831000.00 Dynamic Memory Operations/second
mem_rtns_1 10020 22.7545       682634.73 Dynamic Memory Operations/second
mem_rtns_1 10020 25.0499       751497.01 Dynamic Memory Operations/second
^^^mjb2 is faster than 2.5.63


misc_rtns_1 10000 782.2         7822.00 Auxiliary Loops/second
misc_rtns_1 10000 686.9         6869.00 Auxiliary Loops/second
misc_rtns_1 10000 709.7         7097.00 Auxiliary Loops/second
^^^mjb2 is faster than 2.5.63

dgram_pipe 10000 2357.8       235780.00 DataGram Pipe Messages/second
dgram_pipe 10000 1978       197800.00 DataGram Pipe Messages/second
dgram_pipe 10000 2078.1       207810.00 DataGram Pipe Messages/second
^^^mjb2 is faster than 2.5.63

Let me know if you need further tests/information.

Ciao,
        Paolo

-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
