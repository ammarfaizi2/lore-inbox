Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266968AbTB0VaD>; Thu, 27 Feb 2003 16:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267023AbTB0VaD>; Thu, 27 Feb 2003 16:30:03 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:18902 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S266968AbTB0VaA>; Thu, 27 Feb 2003 16:30:00 -0500
Message-ID: <20030227213954.2125.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com
Date: Fri, 28 Feb 2003 05:39:54 +0800
Subject: [BENCHMARK] AIM9 results. 2.4.19 vs 2.5.58 vs 2.5.63
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
the subject says everything.
I don't post the results that don's show intersting number.

2.4.19
2.5.58
2.5.63

creat-clo 10040 19.4223        19422.31 File Creations and Closes/second
creat-clo 10020 79.7405        79740.52 File Creations and Closes/second
creat-clo 10010 84.3157        84315.68 File Creations and Closes/second
^^^^^ Amazing improvement here

page_test 10000 123.9       210630.00 System Allocations & Pages/second
page_test 10000 102.8       174760.00 System Allocations & Pages/second
page_test 10010 101.898       173226.77 System Allocations & Pages/second
^^^^^Here we are still slowe then 2.4.19

brk_test 10010 48.951       832167.83 System Memory Allocations/second
brk_test 10000 43.7       742900.00 System Memory Allocations/second
brk_test 10020 41.018       697305.39 System Memory Allocations/second
^^^^Slower then .58 and a lot slower then 2.4.19

signal_test 10000 166.1       166100.00 Signal Traps/second
signal_test 10010 156.843       156843.16 Signal Traps/second
signal_test 10000 148.3       148300.00 Signal Traps/second
^^^^Slower then .58 and a lot slower then 2.4.19

exec_test 10000 13.8           69.00 Program Loads/second
exec_test 10030 12.8614           64.31 Program Loads/second
exec_test 10020 12.7745           63.87 Program Loads/second
^^^^ Slower then 2.4.19

fork_test 10000 44.8         4480.00 Task Creations/second
fork_test 10020 24.8503         2485.03 Task Creations/second
fork_test 10000 23.2         2320.00 Task Creations/second
^^^^^ A lot slower then 2.4.19

link_test 10000 155.3         9783.90 Link/Unlink Pairs/second
link_test 10000 135         8505.00 Link/Unlink Pairs/second
link_test 10010 160.739        10126.57 Link/Unlink Pairs/second
^^^^Big improvement here


disk_rw 10060 5.666        29009.94 Random Disk Writes (K)/second
disk_rw 10110 6.42928        32917.90 Random Disk Writes (K)/second
disk_rw 10010 6.39361        32735.26 Random Disk Writes (K)/second
^^^^^Fatser then 2.4.19

sync_disk_rw 16020 0.062422          159.80 Sync Random Disk Writes (K)/second
sync_disk_rw 14600 0.0684932          175.34 Sync Random Disk Writes (K)/second
sync_disk_rw 14410 0.0693963          177.65 Sync Random Disk Writes (K)/second
^^^^ Faster then 2.4.19

array_rtns 10010 13.6863          273.73 Linear Systems Solved/second
array_rtns 10030 13.0608          261.22 Linear Systems Solved/second
array_rtns 10020 11.2774          225.55 Linear Systems Solved/second
^^^^2.5.63 is slower then .58 and slower then 2.4.19

mem_rtns_1 10000 27.7       831000.00 Dynamic Memory Operations/second
mem_rtns_1 10000 24.1       723000.00 Dynamic Memory Operations/second
mem_rtns_1 10020 22.7545       682634.73 Dynamic Memory Operations/second
^^^^^Slow, slow, slow...

misc_rtns_1 10000 782.2         7822.00 Auxiliary Loops/second
misc_rtns_1 10000 706         7060.00 Auxiliary Loops/second
misc_rtns_1 10000 686.9         6869.00 Auxiliary Loops/second
^^^^ Slow too...

dir_rtns_1 10000 85.8       858000.00 Directory Operations/second
dir_rtns_1 10010 101.598      1015984.02 Directory Operations/second
dir_rtns_1 10010 101.998      1019980.02 Directory Operations/second
^^^^ Fast, really fast

shared_memory 10000 2227.4       222740.00 Shared Memory Operations/second
shared_memory 10000 1973.1       197310.00 Shared Memory Operations/second
shared_memory 10000 1955.2       195520.00 Shared Memory Operations/second
^^^^Slow, slow, slow...

tcp_test 10000 661.7        59553.00 TCP/IP Messages/second
tcp_test 10000 532.7        47943.00 TCP/IP Messages/second
tcp_test 10000 539.3        48537.00 TCP/IP Messages/second
^^^^Debug code, I guess.

udp_test 10000 1182.7       118270.00 UDP/IP DataGrams/second
udp_test 10000 931.5        93150.00 UDP/IP DataGrams/second
udp_test 10000 909.3        90930.00 UDP/IP DataGrams/second
^^^^Debug code, I guess.

fifo_test 10000 1207       120700.00 FIFO Messages/second
fifo_test 10000 997.2        99720.00 FIFO Messages/second
fifo_test 10000 1117.3       111730.00 FIFO Messages/second
^^^^^Faster then 2.5.58 but slower then 2.4.19

stream_pipe 10000 2418.6       241860.00 Stream Pipe Messages/second
stream_pipe 10000 2190       219000.00 Stream Pipe Messages/second
stream_pipe 10000 2176.7       217670.00 Stream Pipe Messages/second
^^^^Still slower then 2.4.19

dgram_pipe 10000 2357.8       235780.00 DataGram Pipe Messages/second
dgram_pipe 10000 2040       204000.00 DataGram Pipe Messages/second
dgram_pipe 10000 1978       197800.00 DataGram Pipe Messages/second
^^^^Debug code, I guess.

pipe_cpy 10000 3918       391800.00 Pipe Messages/second
pipe_cpy 10000 2949.9       294990.00 Pipe Messages/second
pipe_cpy 10000 3123.7       312370.00 Pipe Messages/second
^^^^^Faster then 2.5.58 but slower then 2.4.19


Hope it helps.

Ciao,
         Paolo

-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
