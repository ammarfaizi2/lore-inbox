Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136766AbREIRWX>; Wed, 9 May 2001 13:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136769AbREIRWN>; Wed, 9 May 2001 13:22:13 -0400
Received: from news.lucky.net ([193.193.193.102]:13840 "EHLO news.lucky.net")
	by vger.kernel.org with ESMTP id <S136766AbREIRV6>;
	Wed, 9 May 2001 13:21:58 -0400
From: "Mike Gorchak" <mike@malva.com.ua>
To: linux-kernel@vger.kernel.org
Subject: Routing Problem in 2.4.1 kernel
Date: Mon, 7 May 2001 12:29:37 +0300
Organization: Unknown
Message-ID: <9d5q06$s0i$1@news.lucky.net>
X-Trace: news.lucky.net 989227858 28690 193.193.194.126 (7 May 2001 09:30:58 GMT)
X-Complaints-To: usenet@news.lucky.net
X-Priority: 3
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


                           -------------------------      PPP
                          |                         |   --------     POS 1
                          |                         |  /
10.10.28.10/30
                          |                         | /
                          |                         |/    PPP
                          |           10.10.28.9/30 |  ---------     POS 2
                          |                         | /
10.10.28.14/30
                          |                         |/
                          |           10.10.28.13/30|     PPP
                          |                         | ----------     POS 3
                          |                         |/
10.10.28.18/30
                          |           10.10.28.17/30|
                          |                         |
                          |                         |     PPP
                          |           10.10.28.21/30|----------      POS 4
                          |                         |
10.10.28.22/30
                          |                         |
 --------------           |              . . .      |  . . .
|    Server    | Ethernet |    Router               |
| 10.10.0.1/24 |----------| 10.10.0.2/24 . . .      |  . . .
|              |          |                         |
 --------------           |              . . .      |  . . .
                          |                         |
                          |                         |
                          |                         |    PPP
                          |           10.10.28.57/30|---------     POS NN -
1
                          |                         |
10.10.28.58/30
                          |                         |
                          |                         |
                          |           10.10.28.61/30|    PPP
                          |                         |\__________     POS NN
                          |                         |
10.10.28.62/30
                          | def. gateway 10.10.0.1  |
                           -------------------------

Legend:

PPP    - leased line connected by two modems (async, 19200 bps)
Router - Access server with default gateway to Server (10.10.0.1).
         Based on unmodified linux kernel 2.4.1.
Server - Application server based on Windows NT 4.0.
POS    - Remote terminal based on unmodified linux kernel 2.2.16.


   Sometimes one of the POS (random) couldn't ping 10.10.0.1,
but 10.10.0.2 (router) can ping both sides 10.10.0.1 (Server)
and that crazy POS. But in 15-30 minutes this trouble gone, and
POS work fine.
   We have this trouble 1-5 times every day. What that ?



--
----------------------------
Mike Gorchak
CJSC Malva
System Programmer


