Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317633AbSFMO1s>; Thu, 13 Jun 2002 10:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317626AbSFMO1o>; Thu, 13 Jun 2002 10:27:44 -0400
Received: from maggie.one-2-one.net ([217.115.142.82]:24079 "EHLO
	maggie.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id <S317646AbSFMO1G>; Thu, 13 Jun 2002 10:27:06 -0400
Message-ID: <01C212F6.F1993680.klaus.herb@ikon-gmbh.de>
From: Klaus Herb <klaus.herb@ikon-gmbh.de>
Reply-To: "klaus.herb@ikon-gmbh.de" <klaus.herb@ikon-gmbh.de>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: ppp_synctty and in_interrupt
Date: Thu, 13 Jun 2002 16:25:33 +0200
Organization: ikon GmbH
X-Mailer: Microsoft Internet E-Mail/MAPI - 8.0.0.4211
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I am currently developing a tty-Driver which is used for synchronous PPP.

System:
Board		Special Hardware with a Motorola XPC8260 Microcontroller
OS		Elinos V2 with Kernel Version 2.4.3
PPP		pppd and ppp Modules Version 2.4.1

The following Problem occurs:

The ppp_synctty ldisc only calls my ttywrite function in interrupt context. 
But to avoid a race condition I must include a Semaphore in my ttywrite 
function, so I get a Kernel Oops when this Semaphore causes a call to 
schedule().

Is there a way to stop this ppp_synctty ldisc from sending in Interrupt 
Context?
or
Why does this ldisc only write in interrupt context?


Please CC your replay to klaus.herb@ikon-gmbh.de


Thanks!

Klaus Herb

 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Klaus Herb
ikon GmbH
Benzstrasse 17
89079 Ulm
Germany

phone  +49/731/94661-0
fax       +49/731/94661-61
mailto:klaus.herb@ikon-gmbh.de
http://www.ikon-gmbh.de
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

