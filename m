Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbSLPWpK>; Mon, 16 Dec 2002 17:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261973AbSLPWpJ>; Mon, 16 Dec 2002 17:45:09 -0500
Received: from 205-158-62-131.outblaze.com ([205.158.62.131]:55197 "HELO
	ws5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S261908AbSLPWpG>; Mon, 16 Dec 2002 17:45:06 -0500
Message-ID: <20021216225257.5871.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com
Date: Tue, 17 Dec 2002 06:52:57 +0800
Subject: [Benchmark] AIM9 results
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
hw is an Omnibook 6000 (laptop)
fs is Reiserfs

format:
2.4.19
2.5.51
2.5.52

add_double 10030 23.9282       430707.88 Thousand Double Precision Additions/second
add_double 10030 23.7288       427118.64 Thousand Double Precision Additions/second
add_double 10030 23.7288       427118.64 Thousand Double Precision Additions/second

add_float 10000 35.9       430800.00 Thousand Single Precision Additions/second
add_float 10010 35.5644       426773.23 Thousand Single Precision Additions/second
add_float 10010 35.5644       426773.23 Thousand Single Precision Additions/second

add_long 10010 22.1778      1330669.33 Thousand Long Integer Additions/second
add_long 10020 21.9561      1317365.27 Thousand Long Integer Additions/second
add_long 10020 21.9561      1317365.27 Thousand Long Integer Additions/second

add_int 10020 22.0559      1323353.29 Thousand Integer Additions/second
add_int 10020 21.8563      1311377.25 Thousand Integer Additions/second
add_int 10020 21.8563      1311377.25 Thousand Integer Additions/second

add_short 10000 55.4      1329600.00 Thousand Short Integer Additions/second
add_short 10000 54.9      1317600.00 Thousand Short Integer Additions/second
add_short 10000 54.9      1317600.00 Thousand Short Integer Additions/second

creat-clo 10040 19.4223        19422.31 File Creations and Closes/second
creat-clo 10010 87.2128        87212.79 File Creations and Closes/second
creat-clo 10000 75.3        75300.00 File Creations and Closes/second
^^^Here 2.5.* is _a lot_ faster than 2.4.19 but 2.5.52 is slower then 2.5.51

page_test 10000 123.9       210630.00 System Allocations & Pages/second
page_test 10000 105.7       179690.00 System Allocations & Pages/second
page_test 10010 105.095       178661.34 System Allocations & Pages/second
^^^^ 2.5.5* is still slower then 2.4.19

brk_test 10010 48.951       832167.83 System Memory Allocations/second
brk_test 10020 44.6108       758383.23 System Memory Allocations/second
brk_test 10010 43.8561       745554.45 System Memory Allocations/second
^^^^ 2.5.5* is still slower then 2.4.19

jmp_test 10000 4313.7      4313700.00 Non-local gotos/second
jmp_test 10000 4273.2      4273200.00 Non-local gotos/second
jmp_test 10000 4273.1      4273100.00 Non-local gotos/second

signal_test 10000 166.1       166100.00 Signal Traps/second
signal_test 10000 157.4       157400.00 Signal Traps/second
signal_test 10000 159.6       159600.00 Signal Traps/second
^^^^ 2.5.5* is still slower then 2.4.19

exec_test 10000 13.8           69.00 Program Loads/second
exec_test 10020 12.9741           64.87 Program Loads/second
exec_test 10030 12.9611           64.81 Program Loads/second
^^^^ 2.5.5* is still slower then 2.4.19

fork_test 10000 44.8         4480.00 Task Creations/second
fork_test 10020 23.9521         2395.21 Task Creations/second
fork_test 10020 29.0419         2904.19 Task Creations/second
^^^^ 2.5.5* is still slower then 2.4.19

link_test 10000 155.3         9783.90 Link/Unlink Pairs/second
link_test 10000 147.7         9305.10 Link/Unlink Pairs/second
link_test 10010 140.959         8880.42 Link/Unlink Pairs/second
^^^^ 2.5.5* is still slower then 2.4.19

disk_rr 10050 6.96517        35661.69 Random Disk Reads (K)/second
disk_rr 10110 7.51731        38488.63 Random Disk Reads (K)/second
disk_rr 10050 7.46269        38208.96 Random Disk Reads (K)/second
^^^^ 2.5.5* is faster then 2.4.19

disk_rw 10060 5.666        29009.94 Random Disk Writes (K)/second
disk_rw 10000 6.8        34816.00 Random Disk Writes (K)/second
disk_rw 10090 6.73935        34505.45 Random Disk Writes (K)/second
^^^^ 2.5.5* is faster then 2.4.19

disk_rd 10010 38.1618       195388.61 Sequential Disk Reads (K)/second
disk_rd 10020 38.024       194682.63 Sequential Disk Reads (K)/second
disk_rd 10010 38.0619       194877.12 Sequential Disk Reads (K)/second

disk_wrt 10100 8.51485        43596.04 Sequential Disk Writes (K)/second
disk_wrt 10070 9.43396        48301.89 Sequential Disk Writes (K)/second
disk_wrt 10080 9.3254        47746.03 Sequential Disk Writes (K)/second
^^^^ 2.5.5* is faster then 2.4.19

disk_cp 10120 7.31225        37438.74 Disk Copies (K)/second
disk_cp 10010 7.69231        39384.62 Disk Copies (K)/second
disk_cp 10090 7.63132        39072.35 Disk Copies (K)/second
^^^^ 2.5.5* is faster then 2.4.19

sync_disk_rw 16020 0.062422          159.80 Sync Random Disk Writes (K)/second
sync_disk_rw 18790 0.0532198          136.24 Sync Random Disk Writes (K)/second
sync_disk_rw 14570 0.0686342          175.70 Sync Random Disk Writes (K)/second
^^^^ 2.5.5* is faster then 2.4.19

sync_disk_wrt 11220 0.0891266          228.16 Sync Sequential Disk Writes (K)/second
sync_disk_wrt 10150 0.0985222          252.22 Sync Sequential Disk Writes (K)/second
sync_disk_wrt 10130 0.0987167          252.71 Sync Sequential Disk Writes (K)/second
^^^^ 2.5.5* is faster then 2.4.19

sync_disk_cp 10870 0.0919963          235.51 Sync Disk Copies (K)/second
sync_disk_cp 19580 0.102145          261.49 Sync Disk Copies (K)/second
sync_disk_cp 10050 0.0995025          254.73 Sync Disk Copies (K)/second
^^^^ 2.5.5* is faster then 2.4.19

disk_src 10000 118.2         8865.00 Directory Searches/second
disk_src 10010 110.889         8316.68 Directory Searches/second
disk_src 10010 123.477         9260.74 Directory Searches/second
^^^^ 2.5.5* is faster then 2.4.19 and 2.5.52 is faster then 2.5.51

div_double 10000 24.4        73200.00 Thousand Double Precision Divides/second
div_double 10020 24.1517        72455.09 Thousand Double Precision Divides/second
div_double 10010 24.1758        72527.47 Thousand Double Precision Divides/second

div_float 10010 24.3756        73126.87 Thousand Single Precision Divides/second
div_float 10010 24.1758        72527.47 Thousand Single Precision Divides/second
div_float 10010 24.1758        72527.47 Thousand Single Precision Divides/second

div_long 10020 19.9601        17964.07 Thousand Long Integer Divides/second
div_long 10020 19.7605        17784.43 Thousand Long Integer Divides/second
div_long 10010 19.7802        17802.20 Thousand Long Integer Divides/second

div_int 10020 19.9601        17964.07 Thousand Integer Divides/second
div_int 10010 19.7802        17802.20 Thousand Integer Divides/second
div_int 10020 19.7605        17784.43 Thousand Integer Divides/second

div_short 10030 19.9402        17946.16 Thousand Short Integer Divides/second
div_short 10020 19.7605        17784.43 Thousand Short Integer Divides/second
div_short 10010 19.7802        17802.20 Thousand Short Integer Divides/second

fun_cal 10000 62.5     32000000.00 Function Calls (no arguments)/second
fun_cal 10000 61.9     31692800.00 Function Calls (no arguments)/second
fun_cal 10000 61.9     31692800.00 Function Calls (no arguments)/second

fun_cal1 10000 170.4     87244800.00 Function Calls (1 argument)/second
fun_cal1 10010 168.831     86441558.44 Function Calls (1 argument)/second
fun_cal1 10010 168.831     86441558.44 Function Calls (1 argument)/second

fun_cal2 10000 112.5     57600000.00 Function Calls (2 arguments)/second
fun_cal2 10000 111.5     57088000.00 Function Calls (2 arguments)/second
fun_cal2 10010 111.389     57030969.03 Function Calls (2 arguments)/second

fun_cal15 10010 34.0659     17441758.24 Function Calls (15 arguments)/second
fun_cal15 10010 33.7662     17288311.69 Function Calls (15 arguments)/second
fun_cal15 10010 33.7662     17288311.69 Function Calls (15 arguments)/second

sieve 10450 0.861244            4.31 Integer Sieves/second
sieve 10600 0.849057            4.25 Integer Sieves/second
sieve 10600 0.849057            4.25 Integer Sieves/second

mul_double 10020 21.5569       258682.63 Thousand Double Precision Multiplies/second
mul_double 10020 21.3573       256287.43 Thousand Double Precision Multiplies/second
mul_double 10030 21.336       256031.90 Thousand Double Precision Multiplies/second

mul_float 10030 21.5354       258424.73 Thousand Single Precision Multiplies/second
mul_float 10030 21.336       256031.90 Thousand Single Precision Multiplies/second
mul_float 10020 21.3573       256287.43 Thousand Single Precision Multiplies/second

mul_long 10000 947.7       227448.00 Thousand Long Integer Multiplies/second
mul_long 10000 939.6       225504.00 Thousand Long Integer Multiplies/second
mul_long 10000 939.8       225552.00 Thousand Long Integer Multiplies/second

mul_int 10000 951.9       228456.00 Thousand Integer Multiplies/second
mul_int 10000 943.2       226368.00 Thousand Integer Multiplies/second
mul_int 10000 943.3       226392.00 Thousand Integer Multiplies/second

mul_short 10000 759.1       227730.00 Thousand Short Integer Multiplies/second
mul_short 10000 753.4       226020.00 Thousand Short Integer Multiplies/second
mul_short 10000 753.4       226020.00 Thousand Short Integer Multiplies/second

num_rtns_1 10000 467.2        46720.00 Numeric Functions/second
num_rtns_1 10000 463.8        46380.00 Numeric Functions/second
num_rtns_1 10000 463.9        46390.00 Numeric Functions/second

trig_rtns 10010 28.6713       286713.29 Trigonometric Functions/second
trig_rtns 10020 28.3433       283433.13 Trigonometric Functions/second
trig_rtns 10000 28.4       284000.00 Trigonometric Functions/second

matrix_rtns 10000 5964.3       596430.00 Point Transformations/second
matrix_rtns 10000 5906.8       590680.00 Point Transformations/second
matrix_rtns 10000 5906.6       590660.00 Point Transformations/second

array_rtns 10010 13.6863          273.73 Linear Systems Solved/second
array_rtns 10010 13.2867          265.73 Linear Systems Solved/second
array_rtns 10050 13.5323          270.65 Linear Systems Solved/second

string_rtns 10060 9.04573          904.57 String Manipulations/second
string_rtns 10050 8.95522          895.52 String Manipulations/second
string_rtns 10060 8.94632          894.63 String Manipulations/second

mem_rtns_1 10000 27.7       831000.00 Dynamic Memory Operations/second
mem_rtns_1 10010 24.975       749250.75 Dynamic Memory Operations/second
mem_rtns_1 10030 24.327       729810.57 Dynamic Memory Operations/second

mem_rtns_2 10000 1632.5       163250.00 Block Memory Operations/second
mem_rtns_2 10000 1631.8       163180.00 Block Memory Operations/second
mem_rtns_2 10000 1618       161800.00 Block Memory Operations/second

sort_rtns_1 10020 33.6327          336.33 Sort Operations/second
sort_rtns_1 10010 33.0669          330.67 Sort Operations/second
sort_rtns_1 10000 33.1          331.00 Sort Operations/second

misc_rtns_1 10000 782.2         7822.00 Auxiliary Loops/second
misc_rtns_1 10000 738         7380.00 Auxiliary Loops/second
misc_rtns_1 10000 732.1         7321.00 Auxiliary Loops/second

dir_rtns_1 10000 85.8       858000.00 Directory Operations/second
dir_rtns_1 10000 96.9       969000.00 Directory Operations/second
dir_rtns_1 10000 96.9       969000.00 Directory Operations/second

shell_rtns_1 10020 25.9481           25.95 Shell Scripts/second
shell_rtns_1 10030 24.1276           24.13 Shell Scripts/second
shell_rtns_1 10030 23.9282           23.93 Shell Scripts/second

shell_rtns_2 10010 26.0739           26.07 Shell Scripts/second
shell_rtns_2 10000 24.1           24.10 Shell Scripts/second
shell_rtns_2 10030 24.0279           24.03 Shell Scripts/second

shell_rtns_3 10010 26.0739           26.07 Shell Scripts/second
shell_rtns_3 10000 24.1           24.10 Shell Scripts/second
shell_rtns_3 10030 24.0279           24.03 Shell Scripts/second

series_1 10000 31924.9      3192490.00 Series Evaluations/second
series_1 10000 31651.5      3165150.00 Series Evaluations/second
series_1 10000 31649.9      3164990.00 Series Evaluations/second

shared_memory 10000 2227.4       222740.00 Shared Memory Operations/second
shared_memory 10000 1987.5       198750.00 Shared Memory Operations/second
shared_memory 10000 1994.7       199470.00 Shared Memory Operations/second
^^^^ 2.5.5* is still slower then 2.4.19

tcp_test 10000 661.7        59553.00 TCP/IP Messages/second
tcp_test 10000 558.7        50283.00 TCP/IP Messages/second
tcp_test 10000 541.8        48762.00 TCP/IP Messages/second
^^^^ 2.5.5* is still slower then 2.4.19

udp_test 10000 1182.7       118270.00 UDP/IP DataGrams/second
udp_test 10000 972.3        97230.00 UDP/IP DataGrams/second
udp_test 10000 988.1        98810.00 UDP/IP DataGrams/second
^^^^ 2.5.5* is still slower then 2.4.19

fifo_test 10000 1207       120700.00 FIFO Messages/second
fifo_test 10000 1052.3       105230.00 FIFO Messages/second
fifo_test 10000 1083.1       108310.00 FIFO Messages/second
^^^^ 2.5.5* is still slower then 2.4.19

stream_pipe 10000 2418.6       241860.00 Stream Pipe Messages/second
stream_pipe 10000 2281.5       228150.00 Stream Pipe Messages/second
stream_pipe 10000 2258.8       225880.00 Stream Pipe Messages/second
^^^^ 2.5.5* is still slower then 2.4.19

dgram_pipe 10000 2357.8       235780.00 DataGram Pipe Messages/second
dgram_pipe 10000 2112.2       211220.00 DataGram Pipe Messages/second
dgram_pipe 10000 2039.6       203960.00 DataGram Pipe Messages/second
^^^^ 2.5.5* is still slower then 2.4.19

pipe_cpy 10000 3918       391800.00 Pipe Messages/second
pipe_cpy 10000 3139       313900.00 Pipe Messages/second
pipe_cpy 10000 3139.3       313930.00 Pipe Messages/second
^^^^ 2.5.5* is still slower then 2.4.19

ram_copy 10000 19338.7    483854274.00 Memory to Memory Copy/second
ram_copy 10000 19160.9    479405718.00 Memory to Memory Copy/second
ram_copy 10000 19155    479258100.00 Memory to Memory Copy/second


-- 
______________________________________________
http://www.linuxmail.org/
Now with POP3/IMAP access for only US$19.95/yr

Powered by Outblaze
