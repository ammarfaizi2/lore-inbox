Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268599AbRHBCtg>; Wed, 1 Aug 2001 22:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268598AbRHBCt1>; Wed, 1 Aug 2001 22:49:27 -0400
Received: from web11002.mail.yahoo.com ([216.136.131.52]:9486 "HELO
	web11002.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S268486AbRHBCtJ>; Wed, 1 Aug 2001 22:49:09 -0400
Message-ID: <20010802024918.20150.qmail@web11002.mail.yahoo.com>
Date: Wed, 1 Aug 2001 19:49:18 -0700 (PDT)
From: Usman Wahid <mswahid@yahoo.com>
Subject: SMP kernel oops
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
two of our smp linux web servers (2.2.12smp) were
running fine for about a year until a month back. now
they crash randomly from a week to a couple of days
giving wait_on_bh oops. that can happen during both
busy and not so busy times. following is the message
we receive,
wait_on_bh, CPU 0: 
irq: 0 [0 0] 
bh: 1 [0 1] 
<[c010a385] [c016881e] [c0162e6b] [c0163108]
[c016f91e] [c01533cb] 
[c01537c5] [c012611d]

and the mapping
c010a385: synchronize_bh 
c016881e: tcp_v4_unhash 
c0162e6b: tcp_close_state 
c0163108: tcp_close 
c016f91e: inet_release 
c01533cb: sock_release 
c01537c5: sock_close 
c012611d: __fput

appreciate any help,

regards,
saans

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
