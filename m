Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135947AbRAZQVc>; Fri, 26 Jan 2001 11:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135910AbRAZQVX>; Fri, 26 Jan 2001 11:21:23 -0500
Received: from 13dyn226.delft.casema.net ([212.64.76.226]:54791 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S135316AbRAZQVJ>; Fri, 26 Jan 2001 11:21:09 -0500
Message-Id: <200101261621.RAA19330@cave.bitwizard.nl>
Subject: Odd network trace... 
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Date: Fri, 26 Jan 2001 17:21:02 +0100 (MET)
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi, 

In the following trace, near the end, I see the server ack-ing all
data sent sofar, but the client (Linux version 2.2.17 (root@cave) (gcc
version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #4 Fri Oct
27 14:54:42 MEST 2000) does not continue to send further data,
although that IS available (the transfer should end at about 6Mb).

Am I missing something?


17:04:54.054485 client.1880 > server.http: P 283616:285024(1408) ack 1 win 32660 <nop,nop,timestamp 363440696 2799998> (DF)
17:04:54.054632 client.1880 > server.http: P 285024:286432(1408) ack 1 win 32660 <nop,nop,timestamp 363440696 2799998> (DF)
17:04:54.784416 server.http > client.1880: . 1:1(0) ack 280800 win 7112 <nop,nop,timestamp 2799999 363440587,nop,nop, sack 1 {282208:285024} > (DF)
17:04:54.784501 client.1880 > server.http: P 286432:287840(1408) ack 1 win 32660 <nop,nop,timestamp 363440769 2799999> (DF)
17:04:54.804362 server.http > client.1880: . 1:1(0) ack 280800 win 7112 <nop,nop,timestamp 2799999 363440587,nop,nop, sack 1 {282208:286432} > (DF)
17:04:54.804399 client.1880 > server.http: . 280800:282208(1408) ack 1 win 32660 <nop,nop,timestamp 363440771 2799999> (DF)
17:04:55.374394 server.http > client.1880: . 1:1(0) ack 280800 win 7112 <nop,nop,timestamp 2800000 363440587,nop,nop, sack 1 {282208:287840} > (DF)
17:04:55.394320 server.http > client.1880: . 1:1(0) ack 287840 win 72 <nop,nop,timestamp 2800000 363440771> (DF)
17:04:59.444204 client.1880 > server.http: . 287840:287912(72) ack 1 win 32660 <nop,nop,timestamp 363441235 2800000> (DF)
17:04:59.794183 server.http > client.1880: . 1:1(0) ack 287912 win 0 <nop,nop,timestamp 2800006 363441235> (DF)
17:05:07.893790 client.1880 > server.http: . 287911:287911(0) ack 1 win 32660 <nop,nop,timestamp 363442080 2800006> (DF)
17:05:25.012976 client.1880 > server.http: . 287911:287911(0) ack 1 win 32660 <nop,nop,timestamp 363443792 2800006> (DF)
17:05:59.251356 client.1880 > server.http: . 287911:287911(0) ack 1 win 32660 <nop,nop,timestamp 363447216 2800006> (DF)
17:05:59.961324 server.http > client.1880: . 1:1(0) ack 287912 win 0 <nop,nop,timestamp 2800084 363441235> (DF)
17:07:08.438185 client.1880 > server.http: . 287911:287911(0) ack 1 win 32660 <nop,nop,timestamp 363454135 2800084> (DF)
17:07:08.778122 server.http > client.1880: . 1:1(0) ack 287912 win 0 <nop,nop,timestamp 2800175 363441235> (DF)
17:08:43.793808 server.http > client.1880: R 1:1(0) ack 287912 win 0 (DF)



			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
