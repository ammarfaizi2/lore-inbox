Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQJ0Nxe>; Fri, 27 Oct 2000 09:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129280AbQJ0NxY>; Fri, 27 Oct 2000 09:53:24 -0400
Received: from [208.171.173.186] ([208.171.173.186]:24333 "EHLO
	challenge.atlanticweb.com") by vger.kernel.org with ESMTP
	id <S129228AbQJ0NxE>; Fri, 27 Oct 2000 09:53:04 -0400
From: "Chris Swiedler" <ceswiedler_lk@mindspring.com>
To: "Jim Gettys" <jg@pa.dec.com>
Cc: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: RE: Linux's implementation of poll() not scalable?
Date: Fri, 27 Oct 2000 09:56:31 -0400
Message-ID: <NDBBIAJKLMMHOGKNMGFNAEABCOAA.ceswiedler_lk@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <200010261951.MAA18919@pachyderm.pa.dec.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It doesn't practically matter how efficient the X server is when
> you aren't busy, after all.

A simple polling scheme (i.e. not using poll() or select(), just looping
through all fd's trying nonblocking reads) is perfectly efficient when the
server is 100% busy, and perfectly inefficient when there is nothing to do.
I'm not saying that your statements are wrong--in your example, X is calling
select() which is not wasting as much time as a hard-polling loop--but it's
wrong to say that high-load efficiency is the primary concern. I would be
horrified if X took a signifigant portion of the CPU time when many clients
were connected, but none were actually doing anything.

chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
