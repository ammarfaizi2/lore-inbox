Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280136AbRKSRJO>; Mon, 19 Nov 2001 12:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280191AbRKSRIz>; Mon, 19 Nov 2001 12:08:55 -0500
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:54833 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S280136AbRKSRIt>; Mon, 19 Nov 2001 12:08:49 -0500
From: Oliver Neukum <oliver@neukum.org>
To: linux-kernel@vger.kernel.org
Subject: asymmetric speeds in ftp transfers between linux boxes
Date: Mon, 19 Nov 2001 18:06:59 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01111918065906.01742@argo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I did an ftp transfer from linux-2.4.15-pre4(ppc) to linux-2.4.10-SuSE(i386) 
over ethernet and got only 35K/s. In the reverse direction close to 900K/s 
were achieved. No errors were registered in either case.
The problem is repeatable and occured also with 2.4.14(ppc) in place of 
2.4.15-pre4.


	HTH
		Oliver

part of tcpdump (argo is 2.4.15-pre4 on ppc):

15:32:55.150073 argo.neukum.org.32922 > 192.168.232.9.32932: . 
2943234091:2943235539(1448) ack 3088371784 win 5792 <nop,nop,timestamp 225524 
158219> (DF)
15:32:55.151530 192.168.232.9.32932 > argo.neukum.org.32922: . 1:1(0) ack 
3639 win 47784 <nop,nop,timestamp 158240 225524> (DF) [tos 0x8]
15:32:55.151662 192.168.232.9.32932 > argo.neukum.org.32922: F 1:1(0) ack 
3639 win 47784 <nop,nop,timestamp 158240 225524> (DF) [tos 0x8]
15:32:55.151746 argo.neukum.org.32922 > 192.168.232.9.32932: . 3639:3639(0) 
ack 2 win 5792 <nop,nop,timestamp 225524 158240> (DF) [tos 0x8]
15:32:55.151794 192.168.232.9.32783 > argo.neukum.org.ftp: P 
1908125332:1908125356(24) ack 1773235573 win 2920 <nop,nop,timestamp 158240 
225503> (DF) [tos 0x10]
15:32:55.152160 argo.neukum.org.ftp > 192.168.232.9.32783: P 1:21(20) ack 24 
win 5792 <nop,nop,timestamp 225524 158240> (DF) [tos 0x10]
15:32:55.152371 192.168.232.9.32783 > argo.neukum.org.ftp: . 24:24(0) ack 21 
win 2920 <nop,nop,timestamp 158240 225524> (DF) [tos 0x10]
15:32:55.152803 192.168.232.9.32783 > argo.neukum.org.ftp: P 24:48(24) ack 21 
win 2920 <nop,nop,timestamp 158240 225524> (DF) [tos 0x10]
15:32:55.152946 argo.neukum.org.ftp > 192.168.232.9.32783: P 21:33(12) ack 48 
win 5792 <nop,nop,timestamp 225524 158240> (DF) [tos 0x10]
15:32:55.153205 192.168.232.9.32783 > argo.neukum.org.ftp: P 48:54(6) ack 33 
win 2920 <nop,nop,timestamp 158240 225524> (DF) [tos 0x10]
15:32:55.153427 argo.neukum.org.ftp > 192.168.232.9.32783: P 33:81(48) ack 54 
win 5792 <nop,nop,timestamp 225524 158240> (DF) [tos 0x10]
15:32:55.153763 192.168.232.9.32933 > argo.neukum.org.32923: S 
3094161908:3094161908(0) win 5840 <mss 1460,sackOK,timestamp 158240 
0,nop,wscale 1> (DF)
15:32:55.153841 argo.neukum.org.32923 > 192.168.232.9.32933: S 
2943388716:2943388716(0) ack 3094161909 win 5792 <mss 1460,sackOK,timestamp 
225524 158240,nop,wscale 0> (DF)
15:32:55.154043 192.168.232.9.32933 > argo.neukum.org.32923: . 1:1(0) ack 1 
win 2920 <nop,nop,timestamp 158240 225524> (DF)
15:32:55.154133 192.168.232.9.32783 > argo.neukum.org.ftp: P 54:78(24) ack 81 
win 2920 <nop,nop,timestamp 158240 225524> (DF) [tos 0x10]
15:32:55.154366 argo.neukum.org.ftp > 192.168.232.9.32783: P 81:162(81) ack 
78 win 5792 <nop,nop,timestamp 225524 158240> (DF) [tos 0x10] 
15:32:55.156841 argo.neukum.org.32923 > 192.168.232.9.32933: . 1:1449(1448) 
ack 1 win 5792 <nop,nop,timestamp 225524 158240> (DF)
15:32:55.156891 argo.neukum.org.32923 > 192.168.232.9.32933: . 
1449:2897(1448) ack 1 win 5792 <nop,nop,timestamp 225524 158240> (DF)
15:32:55.158290 192.168.232.9.32933 > argo.neukum.org.32923: . 1:1(0) ack 
1449 win 4344 <nop,nop,timestamp 158240 225524> (DF) [tos 0x8] 
15:32:55.158358 argo.neukum.org.32923 > 192.168.232.9.32933: P 
2897:4345(1448) ack 1 win 5792 <nop,nop,timestamp 225524 158240> (DF)
15:32:55.158367 argo.neukum.org.32923 > 192.168.232.9.32933: . 
4345:5793(1448) ack 1 win 5792 <nop,nop,timestamp 225524 158240> (DF)
15:32:55.162076 192.168.232.9.32933 > argo.neukum.org.32923: . 1:1(0) ack 
2897 win 5792 <nop,nop,timestamp 158241 225524> (DF) [tos 0x8]
15:32:55.162108 argo.neukum.org.32923 > 192.168.232.9.32933: . 
5793:7241(1448) ack 1 win 5792 <nop,nop,timestamp 225525 158241> (DF)
15:32:55.163537 192.168.232.9.32933 > argo.neukum.org.32923: . 1:1(0) ack 
2897 win 5792 <nop,nop,timestamp 158241 225524,nop,nop, sack 1 {5793:7241} > 
(DF) [tos 0x8]
15:32:55.163582 argo.neukum.org.32923 > 192.168.232.9.32933: P 
7241:8689(1448) ack 1 win 5792 <nop,nop,timestamp 225525 158241> (DF)
15:32:55.165008 192.168.232.9.32933 > argo.neukum.org.32923: . 1:1(0) ack 
2897 win 5792 <nop,nop,timestamp 158241 225524,nop,nop, sack 1 {5793:8689} > 
(DF) [tos 0x8]
15:32:55.165051 argo.neukum.org.32923 > 192.168.232.9.32933: P 
2897:4345(1448) ack 1 win 5792 <nop,nop,timestamp 225525 158241> (DF)
15:32:55.166482 192.168.232.9.32933 > argo.neukum.org.32923: . 1:1(0) ack 
4345 win 7240 <nop,nop,timestamp 158241 225525,nop,nop, sack 1 {5793:8689} > 
(DF) [tos 0x8]
15:32:55.188845 192.168.232.9.32783 > argo.neukum.org.ftp: . 78:78(0) ack 162 
win 2920 <nop,nop,timestamp 158244 225524> (DF) [tos 0x10]
15:32:55.370024 argo.neukum.org.32923 > 192.168.232.9.32933: . 
4345:5793(1448) ack 1 win 5792 <nop,nop,timestamp 225546 158241> (DF)
15:32:55.371488 192.168.232.9.32933 > argo.neukum.org.32923: . 1:1(0) ack 
8689 win 8688 <nop,nop,timestamp 158262 225546> (DF) [tos 0x8]
15:32:55.371537 argo.neukum.org.32923 > 192.168.232.9.32933: . 
8689:10137(1448) ack 1 win 5792 <nop,nop,timestamp 225546 158262> (DF)
15:32:55.371548 argo.neukum.org.32923 > 192.168.232.9.32933: . 
10137:11585(1448) ack 1 win 5792 <nop,nop,timestamp 225546 158262> (DF)
15:32:55.372963 192.168.232.9.32933 > argo.neukum.org.32923: . 1:1(0) ack 
10137 win 10136 <nop,nop,timestamp 158262 225546> (DF) [tos 0x8]
15:32:55.373008 argo.neukum.org.32923 > 192.168.232.9.32933: P 
11585:13033(1448) ack 1 win 5792 <nop,nop,timestamp 225546 158262> (DF)
15:32:55.373017 argo.neukum.org.32923 > 192.168.232.9.32933: P 
13033:14481(1448) ack 1 win 5792 <nop,nop,timestamp 225546 158262> (DF)
15:32:55.376836 192.168.232.9.32933 > argo.neukum.org.32923: . 1:1(0) ack 
11585 win 11584 <nop,nop,timestamp 158262 225546> (DF) [tos 0x8] 
15:32:55.376865 argo.neukum.org.32923 > 192.168.232.9.32933: . 
14481:15929(1448) ack 1 win 5792 <nop,nop,timestamp 225546 158262> (DF)
15:32:55.378291 192.168.232.9.32933 > argo.neukum.org.32923: . 1:1(0) ack 
11585 win 11584 <nop,nop,timestamp 158262 225546,nop,nop, sack 1 
{14481:15929} > (DF) [tos 0x8]
15:32:55.378328 argo.neukum.org.32923 > 192.168.232.9.32933: . 
15929:17377(1448) ack 1 win 5792 <nop,nop,timestamp 225546 158262> (DF)
15:32:55.379753 192.168.232.9.32933 > argo.neukum.org.32923: . 1:1(0) ack 
11585 win 11584 <nop,nop,timestamp 158263 225546,nop,nop, sack 1 
{14481:17377} > (DF) [tos 0x8]
15:32:55.379789 argo.neukum.org.32923 > 192.168.232.9.32933: P 
11585:13033(1448) ack 1 win 5792 <nop,nop,timestamp 225546 158263> (DF)
15:32:55.381217 192.168.232.9.32933 > argo.neukum.org.32923: . 1:1(0) ack 
13033 win 13032 <nop,nop,timestamp 158263 225546,nop,nop, sack 1 
{14481:17377} > (DF) [tos 0x8]
15:32:55.590020 argo.neukum.org.32923 > 192.168.232.9.32933: P 
13033:14481(1448) ack 1 win 5792 <nop,nop,timestamp 225568 158263> (DF)
15:32:55.591518 192.168.232.9.32933 > argo.neukum.org.32923: . 1:1(0) ack 
17377 win 14480 <nop,nop,timestamp 158284 225568> (DF) [tos 0x8]


