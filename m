Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261470AbTCTOFn>; Thu, 20 Mar 2003 09:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261472AbTCTOFn>; Thu, 20 Mar 2003 09:05:43 -0500
Received: from mailproxy.de.uu.net ([192.76.144.34]:60352 "EHLO
	mailproxy.de.uu.net") by vger.kernel.org with ESMTP
	id <S261470AbTCTOFm>; Thu, 20 Mar 2003 09:05:42 -0500
Message-ID: <7A5D4FEED80CD61192F2001083FC1CF9065139@CHARLY>
From: "Filipau, Ihar" <ifilipau@sussdd.de>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: read() & close()
Date: Thu, 20 Mar 2003 15:14:52 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="koi8-r"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All!

    [ CC me please - I'm not subscribed ]

    I have a question which goes to 2.2 kernels times.
    But I expect newer kernels do the same.

    I have/had a simple issue with multi-threaded programs:

    one thread is doing blocking read(fd) or poll({fd}) on 
    file/socket.

    another thread is doing close(fd).

    I expected first thread will unblock with some kind 
    of error - but nope! It is blocked!

    Is it expected behaviour?

    I was implementing couple of char device 
    drivers and I was putting wake_up_interruptible() 
    into close(). Nice feature - but not more.

    Does it really matters?
    What standards do say about this? - I have none of 
    them :-(   

P. S. Subject looks correct from point of view of bash:
"read() &" and then "close()" does nothing - %1 can only 
be killed ;)

--- Regards&Wishes! With respect
---       Ihar "Philips" Filipau and Phil for friends

- - - - - - - - - - - - - - - - - - - - - - - - -
MCS/Mathematician - System Programmer
Ihar Filipau 
Software entwickler @ SUSS MicroTec Test Systems GmbH, 
Suss-Strasse 1, D-01561 Sacka (bei Dresden)
e-mail: ifilipau@sussdd.de  tel: +49-(0)-352-4073-327
fax: +49-(0)-352-4073-700   web: http://www.suss.com/
