Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266319AbUHBSef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266319AbUHBSef (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 14:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266380AbUHBSef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 14:34:35 -0400
Received: from mxout2.iskon.hr ([213.191.128.16]:27612 "HELO mxout2.iskon.hr")
	by vger.kernel.org with SMTP id S266319AbUHBSe2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 14:34:28 -0400
X-Remote-IP: 213.191.128.14
X-Remote-IP: 213.202.124.154
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Bug in ethernet module b44.c (2.6.7)
X-face: GK)@rjKTDPkyI]TBX{!7&/#rT:#yE\QNK}s(-/!'{dG0r^_>?tIjT[x0aj'Q0u>a
              yv62CGsq'Tb_=>f5p|$~BlO2~A&%<+ry%+o;k'<(2tdowfysFc:?@($aTGX
              4fq`u}~4,0;}y/F*5,9;3.5[dv~C,hl4s*`Hk|1dUaTO[pd[x1OrGu_:1%-lJ]W@
Organization: EINPROGRESS
X-Operating-System: GNU/Linux 2.6.5
Mail-Copies-To: never
References: <lzd629zzcz.fsf@devana.nimium.local>
	<200408021218.21958.vda@port.imtp.ilyichevsk.odessa.ua>
From: Miroslav Zubcic <mvz@nimium.com>
Date: Mon, 02 Aug 2004 20:33:41 +0200
In-Reply-To: <200408021218.21958.vda@port.imtp.ilyichevsk.odessa.ua> (Denis
 Vlasenko's message of "Mon, 2 Aug 2004 12:18:21 +0300")
Message-ID: <lz65814cfu.fsf@anthea.home.int>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> writes:

> Provide strace of hung nmap.

--------------------------------------
execve("/usr/bin/nmap", ["nmap", "-sS", "192.168.3.1"], [/* 45 vars */]) = 0

[...]

read(3, "Iface\tDestination\tGateway \tFlags"..., 1024) = 640
read(3, "", 1024)                       = 0
close(3)                                = 0
munmap(0x4017d000, 4096)                = 0
socket(PF_INET, SOCK_RAW, IPPROTO_RAW)  = 3
setsockopt(3, SOL_SOCKET, SO_BROADCAST, [1], 4) = 0
socket(PF_INET, SOCK_RAW, IPPROTO_RAW)  = 4
setsockopt(4, SOL_SOCKET, SO_BROADCAST, [1], 4) = 0
socket(PF_PACKET, SOCK_RAW, 768)        = 5
ioctl(5, 0x8933, 0xbfffa650)            = 0
ioctl(5, 0x8927, 0xbfffa650)            = 0
ioctl(5, 0x8933, 0xbfffa650)            = 0
bind(5, {sa_family=AF_PACKET, proto=0x03, if3, pkttype=PACKET_HOST, addr(0)={0, }, 20) = 0
setsockopt(5, SOL_PACKET, PACKET_ADD_MEMBERSHIP, "\3\0\0\0\2\0\0\0\0\0\0\0\0\0\0\0", 16) = 0
ioctl(5, 0x8921, 0xbfffa650)            = 0
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 6
ioctl(6, 0x8915, 0xbfffa4c0)            = 0
ioctl(6, 0x891b, 0xbfffa4c0)            = 0
close(6)                                = 0
setsockopt(5, SOL_SOCKET, 0x1a /* SO_??? */, "r\0\0\0\210\35\r\10", 8) = 0
gettimeofday({1091471189, 938221}, NULL) = 0
setsockopt(4, SOL_IP, IP_HDRINCL, [1], 4) = 0
sendto(4, "E\0\0\34\317\6\0\0003\1\3651\0\0\0\0\300\250\3\1\10\0\376"..., 28, 0, {sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("192.168.3.1")}, 16) =
 28
gettimeofday({1091471189, 938342}, NULL) = 0
setsockopt(3, SOL_IP, IP_HDRINCL, [1], 4) = 0
sendto(3, "E\0\0(t\377\0\0001\6\215u\300\250\3\n\300\250\3\1\214\n"..., 40, 0, {sa_family=AF_INET, sin_port=htons(80), sin_addr=inet_addr("192.168.3.1")}, 16) = 
40
gettimeofday({1091471189, 938429}, NULL) = 0
gettimeofday({1091471189, 938446}, NULL) = 0
gettimeofday({1091471189, 938464}, NULL) = 0
gettimeofday({1091471189, 938483}, NULL) = 0
gettimeofday({1091471189, 938501}, NULL) = 0
select(6, [5], NULL, NULL, {0, 20000})  = 0 (Timeout)
gettimeofday({1091471189, 958183}, NULL) = 0
select(6, [5], NULL, NULL, {0, 20000})  = 0 (Timeout)
gettimeofday({1091471189, 978194}, NULL) = 0
select(6, [5], NULL, NULL, {0, 20000})  = 0 (Timeout)
gettimeofday({1091471189, 998175}, NULL) = 0
select(6, [5], NULL, NULL, {0, 20000})  = 0 (Timeout)
gettimeofday({1091471190, 18172}, NULL) = 0
select(6, [5], NULL, NULL, {0, 20000})  = 0 (Timeout)
gettimeofday({1091471190, 38168}, NULL) = 0

[...]

... and so on and on until interrupted on the console.

[...]

--- SIGINT (Interrupt) @ 0 (0) ---
write(2, "caught SIGINT signal, cleaning u"..., 34) = 34
munmap(0x40017000, 4096)                = 0
exit_group(1)       

--------------------------------------

> Does just setting promisc with ifconfig or ip tool helps?

Yes, 'ifconfig eth0 promisc' works as a workaround. Just like when I
do it indirectly with tcpdump(8).


-- 
Many men would sooner die then think. In fact they do.
		-- Bertrand Russell

