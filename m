Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271833AbRHUTBa>; Tue, 21 Aug 2001 15:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271824AbRHUTBU>; Tue, 21 Aug 2001 15:01:20 -0400
Received: from mail.webmaster.com ([216.152.64.131]:4555 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S271833AbRHUTBL>; Tue, 21 Aug 2001 15:01:11 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: select() says closed socket readable
Date: Tue, 21 Aug 2001 12:01:25 -0700
Message-ID: <NOEJJDACGOHCKNCOGFOMIELCDFAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2479.0006
In-Reply-To: <E15ZGQN-0008QO-00@the-village.bc.nu>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > No, because 'select' is defined to work the same on both
> > blocking and
> > non-blocking sockets. Roughly, select should hit on read if a
> > non-blocking
> > read wouldn't return 'would block'.

> Select is not reliable for a blocking socket in all cases. There
> is always
> a risk select may return "data to read" and the read will find
> there is now
> none. It isnt going to bite anyone on Linux with our current protocols but
> it may bite portable code

	I should have continued my sentence with "if it was issued at the instant
'select' made that decision." Using 'select' on blocking sockets is usually
an error. Nevertheless, select itself is defined to work the same on both
blocking and non-blocking sockets. In general, there is no way the operating
system can make guarantees about the future state of a socket.

	DS

