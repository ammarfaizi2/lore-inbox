Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261664AbSKXVQc>; Sun, 24 Nov 2002 16:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261669AbSKXVQc>; Sun, 24 Nov 2002 16:16:32 -0500
Received: from 205-158-62-68.outblaze.com ([205.158.62.68]:14609 "HELO
	spf0.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S261664AbSKXVQ3>; Sun, 24 Nov 2002 16:16:29 -0500
Message-ID: <20021124212337.30844.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com
Date: Mon, 25 Nov 2002 05:23:37 +0800
Subject: [Benchmark] AIM results
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-3.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I've ran the AIM benchmark against 2.4.19 and 2.5.49 on my laptop (PIII@800 Reiserfs)

add_double 10010 29.4705       530469.53 Thousand Double Precision Additions/second
add_double 10040 29.1833       525298.80 Thousand Double Precision Additions/second

add_float 10000 44.2       530400.00 Thousand Single Precision Additions/second
add_float 10000 43.8       525600.00 Thousand Single Precision Additions/second

add_long 10010 27.2727      1636363.64 Thousand Long Integer Additions/second
add_long 10020 27.0459      1622754.49 Thousand Long Integer Additions/second

add_int 10000 27.2      1632000.00 Thousand Integer Additions/second
add_int 10030 26.9192      1615154.54 Thousand Integer Additions/second

add_short 10000 68.2      1636800.00 Thousand Short Integer Additions/second
add_short 10000 67.6      1622400.00 Thousand Short Integer Additions/second

creat-clo 10020 23.7525        23752.50 File Creations and Closes/second
creat-clo 10030 18.9432        18943.17 File Creations and Closes/second
^^^^^ Here 2.4.19 is faster then 2.5.49

page_test 10000 152.9       259930.00 System Allocations & Pages/second
page_test 10010 128.971       219250.75 System Allocations & Pages/second
^^^^^ Here 2.4.19 is faster then 2.5.49

brk_test 10000 63.5      1079500.00 System Memory Allocations/second
brk_test 10010 53.9461       917082.92 System Memory Allocations/second
^^^^^ Here 2.4.19 is faster then 2.5.49

jmp_test 10000 5308.5      5308500.00 Non-local gotos/second
jmp_test 10000 5261.6      5261600.00 Non-local gotos/second

signal_test 10000 204.5       204500.00 Signal Traps/second
signal_test 10000 146.5       146500.00 Signal Traps/second
^^^^^ Here 2.4.19 is faster then 2.5.49

exec_test 10010 16.6833           83.42 Program Loads/second
exec_test 10030 15.5533           77.77 Program Loads/second
^^^^^ Here 2.4.19 is faster then 2.5.49

fork_test 10000 56.2         5620.00 Task Creations/second
fork_test 10010 32.967         3296.70 Task Creations/second
^^^^^ Here 2.4.19 is faster then 2.5.49

link_test 10000 224.1        14118.30 Link/Unlink Pairs/second
link_test 10000 125.7         7919.10 Link/Unlink Pairs/second
^^^^^ Here 2.4.19 is faster then 2.5.49

disk_rr 10110 7.71513        39501.48 Random Disk Reads (K)/second
disk_rr 10010 7.89211        40407.59 Random Disk Reads (K)/second

disk_rw 10090 6.44202        32983.15 Random Disk Writes (K)/second
disk_rw 10030 7.17846        36753.74 Random Disk Writes (K)/second
^^^^^ Here 2.5.49 is faster then 2.4.19

disk_rd 10010 38.1618       195388.61 Sequential Disk Reads (K)/second
disk_rd 10000 38       194560.00 Sequential Disk Reads (K)/second

disk_wrt 10070 9.63257        49318.77 Sequential Disk Writes (K)/second
disk_wrt 10060 9.94036        50894.63 Sequential Disk Writes (K)/second

disk_cp 10040 8.26693        42326.69 Disk Copies (K)/second
disk_cp 10040 8.06773        41306.77 Disk Copies (K)/second

sync_disk_rw 15080 0.066313          169.76 Sync Random Disk Writes (K)/second
sync_disk_rw 14310 0.0698812          178.90 Sync Random Disk Writes (K)/second
^^^^^ Here 2.5.49 is faster then 2.4.19

sync_disk_wrt 11170 0.0895255          229.19 Sync Sequential Disk Writes (K)/second
sync_disk_wrt 10100 0.0990099          253.47 Sync Sequential Disk Writes (K)/second
^^^^^ Here 2.5.49 is faster then 2.4.19

sync_disk_cp 11020 0.0907441          232.30 Sync Disk Copies (K)/second
sync_disk_cp 10010 0.0999001          255.74 Sync Disk Copies (K)/second
^^^^^ Here 2.5.49 is faster then 2.4.19

disk_src 10000 154.2        11565.00 Directory Searches/second
disk_src 10000 141.8        10635.00 Directory Searches/second

div_double 10000 30        90000.00 Thousand Double Precision Divides/second
div_double 10010 29.7702        89310.69 Thousand Double Precision Divides/second

div_float 10020 30.0399        90119.76 Thousand Single Precision Divides/second
div_float 10020 29.7405        89221.56 Thousand Single Precision Divides/second

div_long 10020 24.5509        22095.81 Thousand Long Integer Divides/second
div_long 10020 24.3513        21916.17 Thousand Long Integer Divides/second

div_int 10020 24.5509        22095.81 Thousand Integer Divides/second
div_int 10030 24.327        21894.32 Thousand Integer Divides/second

div_short 10010 24.5754        22117.88 Thousand Short Integer Divides/second
div_short 10020 24.3513        21916.17 Thousand Short Integer Divides/second

fun_cal 10000 76.9     39372800.00 Function Calls (no arguments)/second
fun_cal 10010 76.2238     39026573.43 Function Calls (no arguments)/second

fun_cal1 10000 209.7    107366400.00 Function Calls (1 argument)/second
fun_cal1 10010 207.792    106389610.39 Function Calls (1 argument)/second

fun_cal2 10000 138.4     70860800.00 Function Calls (2 arguments)/second
fun_cal2 10000 137.2     70246400.00 Function Calls (2 arguments)/second

fun_cal15 10010 41.958     21482517.48 Function Calls (15 arguments)/second
fun_cal15 10000 41.6     21299200.00 Function Calls (15 arguments)/second

sieve 10330 0.871249            4.36 Integer Sieves/second
sieve 10590 0.849858            4.25 Integer Sieves/second

mul_double 10030 26.5204       318245.26 Thousand Double Precision Multiplies/second
mul_double 10030 25.5234       306281.16 Thousand Double Precision Multiplies/second

mul_float 10030 26.5204       318245.26 Thousand Single Precision Multiplies/second
mul_float 10010 25.7742       309290.71 Thousand Single Precision Multiplies/second

mul_long 10000 1166.4       279936.00 Thousand Long Integer Multiplies/second
mul_long 10000 1156.9       277656.00 Thousand Long Integer Multiplies/second

mul_int 10000 1171.6       281184.00 Thousand Integer Multiplies/second
mul_ine 10000 1162.1       278904.00 Thousand Integer Multiplies/second

mul_short 10000 934.3       280290.00 Thousand Short Integer Multiplies/second
mul_short 10000 927.4       278220.00 Thousand Short Integer Multiplies/second

num_rtns_1 10000 575.2        57520.00 Numeric Functions/second
num_rtns_1 10000 571.5        57150.00 Numeric Functions/second

trig_rtns 10010 35.2647       352647.35 Trigonometric Functions/second
trig_rtns 10020 34.9301       349301.40 Trigonometric Functions/second

matrix_rtns 10000 7337.6       733760.00 Point Transformations/second
matrix_rtns 10000 7274.4       727440.00 Point Transformations/second

array_rtns 10030 16.8495          336.99 Linear Systems Solved/second
array_rtns 10050 16.6169          332.34 Linear Systems Solved/second

string_rtns 10050 11.1443         1114.43 String Manipulations/second
string_rtns 10060 11.0338         1103.38 String Manipulations/second

mem_rtns_1 10020 32.3353       970059.88 Dynamic Memory Operations/second
mem_rtns_1 10030 30.5085       915254.24 Dynamic Memory Operations/second

mem_rtns_2 10000 2009.5       200950.00 Block Memory Operations/second
mem_rtns_2 10000 1992.3       199230.00 Block Memory Operations/second

sort_rtns_1 10000 41.4          414.00 Sort Operations/second
sort_rtns_1 10010 40.8591          408.59 Sort Operations/second

misc_rtns_1 10000 951.9         9519.00 Auxiliary Loops/second
misc_rtns_1 10000 870         8700.00 Auxiliary Loops/second

dir_rtns_1 10000 105.5      1055000.00 Directory Operations/second
dir_rtns_1 10000 91.1       911000.00 Directory Operations/second
^^^^^ Here 2.4.49 is faster then 2.4.19

shell_rtns_1 10000 31.3           31.30 Shell Scripts/second
shell_rtns_1 10010 28.5714           28.57 Shell Scripts/second

shell_rtns_2 10010 31.3686           31.37 Shell Scripts/second
shell_rtns_2 10030 28.6142           28.61 Shell Scripts/second

shell_rtns_3 10010 31.3686           31.37 Shell Scripts/second
shell_rtns_3 10020 28.6427           28.64 Shell Scripts/second

series_1 10000 39306.1      3930610.00 Series Evaluations/second
series_1 10000 38976.2      3897620.00 Series Evaluations/second

shared_memory 10000 2742.2       274220.00 Shared Memory Operations/second
shared_memory 10000 2360.6       236060.00 Shared Memory Operations/second
^^^^^ Here 2.4.19 is faster then 2.5.49

tcp_test 10000 805.5        72495.00 TCP/IP Messages/second
tcp_test 10000 660.7        59463.00 TCP/IP Messages/second
^^^^^ Here 2.4.19 is faster then 2.5.49 (debug?)

udp_test 10000 1448.6       144860.00 UDP/IP DataGrams/second
udp_test 10000 1115.7       111570.00 UDP/IP DataGrams/second
^^^^^ Here 2.4.19 is faster then 2.5.49 (debug?)

fifo_test 10000 1568.7       156870.00 FIFO Messages/second
fifo_test 10000 1041.6       104160.00 FIFO Messages/second
^^^^^ Here 2.4.19 is faster then 2.5.49

stream_pipe 10000 2807.4       280740.00 Stream Pipe Messages/second
stream_pipe 10000 2602.3       260230.00 Stream Pipe Messages/second
^^^^^ Here 2.4.19 is faster then 2.5.49

dgram_pipe 10000 2756.9       275690.00 DataGram Pipe Messages/second
dgram_pipe 10000 2460.5       246050.00 DataGram Pipe Messages/second
^^^^^ Here 2.4.19 is faster then 2.5.49

pipe_cpy 10000 4164.8       416480.00 Pipe Messages/second
pipe_cpy 10000 3736.4       373640.00 Pipe Messages/second
^^^^^ Here 2.4.19 is faster then 2.5.49

ram_copy 10000 23801.6    595516032.00 Memory to Memory Copy/second
ram_copy 10000 23583    590046660.00 Memory to Memory Copy/second

Ciao,
        Paolo
-- 
______________________________________________
http://www.linuxmail.org/
Now with POP3/IMAP access for only US$19.95/yr

Powered by Outblaze
