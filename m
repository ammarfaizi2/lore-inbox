Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266565AbRGGVYi>; Sat, 7 Jul 2001 17:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266567AbRGGVY2>; Sat, 7 Jul 2001 17:24:28 -0400
Received: from eax.student.umd.edu ([129.2.236.2]:61453 "EHLO
	eax.student.umd.edu") by vger.kernel.org with ESMTP
	id <S266565AbRGGVYQ>; Sat, 7 Jul 2001 17:24:16 -0400
Date: Sat, 7 Jul 2001 17:24:15 -0500 (EST)
From: Adam <adam@eax.com>
X-X-Sender: <adam@eax.student.umd.edu>
To: <linux-kernel@vger.kernel.org>
Subject: networking in v2.2 vs v2.4 kernels.
Message-ID: <Pine.LNX.4.33.0107071719250.1430-100000@eax.student.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kernels:
	Linux pepsi 2.4.6-pre1-packet #1 SMP Tue Jun 12 02:12:32 EDT 2001 i686
	Linux eax 2.2.20pre6 #1 Wed Jun 27 10:39:14 EST 2001 i586

I have a program which does :

  flags =  MSG_WAITALL;
  rawsock = socket(PF_INET,SOCK_RAW,IPPROTO_TCP);
  bytesread = recvfrom(rawsock,&buf,buflen,flags,
                       (struct sockaddr*)(&from),&fromlen

on my 2.4.x box it works pretty much as expected (excpet that for some
reason the from.sin_port is always set to 0).

However if I try to run the same piece of code on 2.2 kernel it basically
never blocks and always immediatelly returns, and for second thing, it
seems as if it getting some random junk from loopback device, and it never
seems to get any data from any other interface..

any idea what could the difference in behavior between 2.4 and 2.2 ?

-- 
Adam
http://www.eax.com      The Supreme Headquarters of the 32 bit registers


