Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264919AbTA1HAl>; Tue, 28 Jan 2003 02:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267322AbTA1HAl>; Tue, 28 Jan 2003 02:00:41 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:5550 "EHLO gw1.cosmosbay.com")
	by vger.kernel.org with ESMTP id <S264919AbTA1HAi>;
	Tue, 28 Jan 2003 02:00:38 -0500
Message-ID: <02c601c2c69c$05668d80$1d00a8c0@edumazet>
From: "dada1" <dada1@cosmosbay.com>
To: <kuznet@ms2.inr.ac.ru>, "Christopher Faylor" <cgf@redhat.com>
Cc: <davem@redhat.com>, <andersg@0x63.nu>, <lkernel2003@tuxers.net>,
       <linux-kernel@vger.kernel.org>, <tobi@tobi.nu>
References: <200301280355.GAA27468@sex.inr.ac.ru>
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x, through Cisco PIX
Date: Tue, 28 Jan 2003 08:08:10 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: <kuznet@ms2.inr.ac.ru>
> Can you make tcpdump of this session which looks like tcpdump with -S? :-)
>
>
> Alexey

Hello Alexey

I do have a lot of such hangs too.

client is a linux 2.4.20 machine, but hangs were given by other OS as well.
server is a linux-2.5.59 SMP machine, traffic control in operation,

07:28:28.176006 client.1022 > server.22: S 3603063450:3603063450(0) win 5840
<mss 1460,sackOK,timestamp 359716783 0,no
p,wscale 0> (DF)
07:28:28.176151 server.22 > client.1022: S 420199885:420199885(0) ack
3603063451 win 5840 <mss 1460> (DF)
07:28:28.580529 client.1022 > server.22: . ack 420199886 win 5840 (DF)
07:28:28.583078 server.22 > client.1022: P 420199886:420199909(23) ack
3603063451 win 5840 (DF)
07:28:29.006494 client.1022 > server.22: . ack 420199909 win 5840 (DF) [tos
0x10]
07:28:29.007644 client.1022 > server.22: P 3603063451:3603063472(21) ack
420199909 win 5840 (DF) [tos 0x10]
07:28:29.007743 server.22 > client.1022: . ack 3603063472 win 5840 (DF)
07:28:29.008246 server.22 > client.1022: P 420199909:420200185(276) ack
3603063472 win 5840 (DF)
07:28:29.575223 client.1022 > server.22: P 3603063472:3603063628(156) ack
420200185 win 6432 (DF) [tos 0x10]
07:28:29.576148 client.1022 > server.22: P 3603063628:3603063680(52) ack
420200185 win 6432 (DF) [tos 0x10]
07:28:29.596173 server.22 > client.1022: P 420200185:420200197(12) ack
3603063680 win 5840 (DF)
07:28:30.020642 client.1022 > server.22: P 3603063680:3603063700(20) ack
420200197 win 6432 (DF) [tos 0x10]
07:28:30.059904 server.22 > client.1022: . ack 3603063700 win 5840 (DF)
07:28:31.407346 client.1022 > server.22: P 3603063680:3603063700(20) ack
420200197 win 6432 (DF) [tos 0x10]
07:28:31.407464 server.22 > client.1022: . ack 3603063700 win 5840 (DF)
07:28:34.369344 server.22 > client.1022: P 420200197:420200209(12) ack
3603063700 win 5840 (DF)
07:28:34.784326 client.1022 > server.22: P 3603063700:3603063840(140) ack
420200209 win 6432 (DF) [tos 0x10]
07:28:34.784398 server.22 > client.1022: . ack 3603063840 win 6432 (DF)
07:28:34.786551 server.22 > client.1022: P 420200209:420200221(12) ack
3603063840 win 6432 (DF)
07:28:35.268516 client.1022 > server.22: . ack 420200221 win 6432 (DF) [tos
0x10]
07:28:38.597375 client.1022 > server.22: P 3603063840:3603063868(28) ack
420200221 win 6432 (DF) [tos 0x10]
07:28:38.605463 server.22 > client.1022: P 420200221:420200233(12) ack
3603063868 win 6432 (DF)
07:28:39.096028 client.1022 > server.22: . ack 420200233 win 6432 (DF) [tos
0x10]
07:28:39.099880 client.1022 > server.22: P 3603063868:3603064016(148) ack
420200233 win 6432 (DF) [tos 0x10]
07:28:39.101205 server.22 > client.1022: P 420200233:420200245(12) ack
3603064016 win 6432 (DF)
07:28:39.665364 client.1022 > server.22: P 3603064016:3603064028(12) ack
420200245 win 6432 (DF) [tos 0x10]
07:28:39.681917 server.22 > client.1022: P 420200245:420200377(132) ack
3603064028 win 6432 (DF) [tos 0x10]
07:28:39.957853 server.22 > client.1022: P 420200377:420200413(36) ack
3603064028 win 6432 (DF) [tos 0x10]
07:28:40.191540 client.1022 > server.22: . ack 420200377 win 7504 (DF) [tos
0x10]
07:28:40.432214 client.1022 > server.22: . ack 420200413 win 7504 (DF) [tos
0x10]
07:28:41.928298 client.1022 > server.22: P 3603064028:3603064048(20) ack
420200413 win 7504 (DF) [tos 0x10]
07:28:41.938316 server.22 > client.1022: P 420200413:420200457(44) ack
3603064048 win 6432 (DF) [tos 0x10]
07:28:42.123677 client.1022 > server.22: P 3603064048:3603064068(20) ack
420200413 win 7504 (DF) [tos 0x10]
07:28:42.134272 server.22 > client.1022: P 420200457:420200501(44) ack
3603064068 win 6432 (DF) [tos 0x10]
07:28:42.483256 client.1022 > server.22: P 3603064068:3603064108(40) ack
420200457 win 7504 (DF) [tos 0x10]
07:28:42.494187 server.22 > client.1022: P 420200501:420200569(68) ack
3603064108 win 6432 (DF) [tos 0x10]
07:28:42.679902 client.1022 > server.22: . ack 420200501 win 7504 (DF) [tos
0x10]
07:28:42.792933 client.1022 > server.22: P 3603064108:3603064128(20) ack
420200501 win 7504 (DF) [tos 0x10]
07:28:42.803135 server.22 > client.1022: P 420200569:420200613(44) ack
3603064128 win 6432 (DF) [tos 0x10]
07:28:42.825978 client.1022 > server.22: P 3603064128:3603064148(20) ack
420200501 win 7504 (DF) [tos 0x10]
07:28:42.836109 server.22 > client.1022: P 420200613:420200657(44) ack
3603064148 win 6432 (DF) [tos 0x10]
07:28:43.408817 client.1022 > server.22: P 3603064148:3603064188(40) ack
420200501 win 7504 (DF) [tos 0x10]
07:28:43.461886 server.22 > client.1022: . ack 3603064188 win 6432 (DF) [tos
0x10]
07:28:43.589866 server.22 > client.1022: P 420200501:420200569(68) ack
3603064188 win 6432 (DF) [tos 0x10]
07:28:44.087198 client.1022 > server.22: . ack 420200569 win 7504 (DF) [tos
0x10]
07:28:45.410465 server.22 > client.1022: P ack 3603064188 win 6432 (DF) [tos
0x10]
07:28:49.050628 server.22 > client.1022: P ack 3603064188 win 6432 (DF) [tos
0x10]
07:28:56.328994 server.22 > client.1022: P ack 3603064188 win 6432 (DF) [tos
0x10]
07:29:10.886716 server.22 > client.1022: P ack 3603064188 win 6432 (DF) [tos
0x10]
07:29:40.003185 server.22 > client.1022: P ack 3603064188 win 6432 (DF) [tos
0x10]
07:30:38.235034 server.22 > client.1022: P ack 3603064188 win 6432 (DF) [tos
0x10]
07:32:34.696797 server.22 > client.1022: P ack 3603064188 win 6432 (DF) [tos
0x10]
07:34:34.678762 server.22 > client.1022: P ack 3603064188 win 6432 (DF) [tos
0x10]
07:36:34.660724 server.22 > client.1022: P ack 3603064188 win 6432 (DF) [tos
0x10]
07:38:34.642703 server.22 > client.1022: P ack 3603064188 win 6432 (DF) [tos
0x10]
07:40:34.623666 server.22 > client.1022: P ack 3603064188 win 6432 (DF) [tos
0x10]
07:42:34.605632 server.22 > client.1022: P ack 3603064188 win 6432 (DF) [tos
0x10]
07:44:34.587601 server.22 > client.1022: P ack 3603064188 win 6432 (DF) [tos
0x10]
07:46:34.569566 server.22 > client.1022: P ack 3603064188 win 6432 (DF) [tos
0x10]

netstat -an on the server tells us that 156 bytes are waiting in the send
queue.

Thanks for your help

