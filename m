Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbTEEVHW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 17:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbTEEVHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 17:07:22 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:43734 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S261315AbTEEVHS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 17:07:18 -0400
Message-ID: <20030505211942.1606.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org, akpm@digeo.com, mbligh@aracnet.com
Cc: ciarrocchi@linuxmail.org
Date: Tue, 06 May 2003 05:19:42 +0800
Subject: [BENCHMARK AIM9] Regressions in 2.5.69
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-3.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all/Andrew/Martin,
I noticed regression in a few tests,
I deleted the results of tests that don't show differences between the two kernel version.

Hope it helps.

Ciao,
		Paolo
		
2.5.67
2.5.69

creat-clo 10010 86.8132        86813.19 File Creations and Closes/second
creat-clo 10030 22.0339        22033.90 File Creations and Closes/second
^^^^BIG REGRESSION

page_test 10000 110.2       187340.00 System Allocations & Pages/second
page_test 10000 102.9       174930.00 System Allocations & Pages/second
^^^^REGRESSION

brk_test 10010 51.8482       881418.58 System Memory Allocations/second
brk_test 10010 45.0549       765934.07 System Memory Allocations/second
^^^^REGRESSION

jmp_test 10000 4270.1      4270100.00 Non-local gotos/second
jmp_test 10000 4268.9      4268900.00 Non-local gotos/second

signal_test 10010 159.84       159840.16 Signal Traps/second
signal_test 10000 109       109000.00 Signal Traps/second
^^^^REGRESSION

exec_test 10040 12.9482           64.74 Program Loads/second
exec_test 10050 11.7413           58.71 Program Loads/second
^^^^REGRESSION

fork_test 10020 27.3453         2734.53 Task Creations/second
fork_test 10020 23.4531         2345.31 Task Creations/second
^^^^REGRESSION

link_test 10000 146.5         9229.50 Link/Unlink Pairs/second
link_test 10020 55.1896         3476.95 Link/Unlink Pairs/second
^^^^REGRESSION

disk_rr 10020 7.08583        36279.44 Random Disk Reads (K)/second
disk_rr 10020 5.28942        27081.84 Random Disk Reads (K)/second
^^^^REGRESSION

disk_rw 10140 6.41026        32820.51 Random Disk Writes (K)/second
disk_rw 10100 4.85149        24839.60 Random Disk Writes (K)/second
^^^^REGRESSION

disk_rd 10020 38.024       194682.63 Sequential Disk Reads (K)/second
disk_rd 10010 37.7622       193342.66 Sequential Disk Reads (K)/second

disk_wrt 10090 8.72151        44654.11 Sequential Disk Writes (K)/second
disk_wrt 10050 6.16915        31586.07 Sequential Disk Writes (K)/second
^^^^REGRESSION

disk_cp 10070 7.24926        37116.19 Disk Copies (K)/second
disk_cp 10140 5.32544        27266.27 Disk Copies (K)/second
^^^^REGRESSION

sync_disk_rw 14450 0.0692042          177.16 Sync Random Disk Writes (K)/second
sync_disk_rw 14680 0.0681199          174.39 Sync Random Disk Writes (K)/second

sync_disk_wrt 11330 0.0882613          225.95 Sync Sequential Disk Writes (K)/second
sync_disk_wrt 10260 0.0974659          249.51 Sync Sequential Disk Writes (K)/second

sync_disk_cp 11080 0.0902527          231.05 Sync Disk Copies (K)/second
sync_disk_cp 10040 0.0996016          254.98 Sync Disk Copies (K)/second

disk_src 10000 113         8475.00 Directory Searches/second
disk_src 10020 45.2096         3390.72 Directory Searches/second
^^^^BIG REGRESSION

mem_rtns_1 10030 21.4357       643070.79 Dynamic Memory Operations/second
mem_rtns_1 10000 25       750000.00 Dynamic Memory Operations/second

mem_rtns_2 10000 1631.9       163190.00 Block Memory Operations/second
mem_rtns_2 10010 1614.79       161478.52 Block Memory Operations/second

misc_rtns_1 10000 728.2         7282.00 Auxiliary Loops/second
misc_rtns_1 10000 353.1         3531.00 Auxiliary Loops/second
^^^^BIG REGRESSION

shell_rtns_1 10020 23.7525           23.75 Shell Scripts/second
shell_rtns_1 10040 19.9203           19.92 Shell Scripts/second
^^^^ REGRESSION

shell_rtns_2 10040 23.8048           23.80 Shell Scripts/second
shell_rtns_2 10020 19.9601           19.96 Shell Scripts/second
^^^^REGRESSION

shell_rtns_3 10040 23.8048           23.80 Shell Scripts/second
shell_rtns_3 10040 19.9203           19.92 Shell Scripts/second
^^^^REGRESSION

tcp_test 10000 605.8        54522.00 TCP/IP Messages/second
tcp_test 10000 176.9        15921.00 TCP/IP Messages/second
^^^^REGRESSION

udp_test 10000 1091.5       109150.00 UDP/IP DataGrams/second
udp_test 10010 446.853        44685.31 UDP/IP DataGrams/second
^^^^REGRESSION

fifo_test 10000 1045.6       104560.00 FIFO Messages/second
fifo_test 10000 772.1        77210.00 FIFO Messages/second
^^^^REGRESSION

stream_pipe 10000 2228.3       222830.00 Stream Pipe Messages/second
stream_pipe 10000 738        73800.00 Stream Pipe Messages/second
^^^^REGRESSION

dgram_pipe 10000 2204.7       220470.00 DataGram Pipe Messages/second
dgram_pipe 10010 718.581        71858.14 DataGram Pipe Messages/second
^^^^REGRESSION

pipe_cpy 10000 3165.3       316530.00 Pipe Messages/second
pipe_cpy 10000 2787.1       278710.00 Pipe Messages/second
^^^^REGRESSION


-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
