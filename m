Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263447AbTH2Lz4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 07:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264535AbTH2Lz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 07:55:56 -0400
Received: from mail.webmaster.com ([216.152.64.131]:26330 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S263447AbTH2Lzy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 07:55:54 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <jlnance@unity.ncsu.edu>, <root@mauve.demon.co.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Lockless file readingu
Date: Fri, 29 Aug 2003 04:55:39 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKOEPOFMAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <20030829100011.GA663@ncsu.edu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Fri, Aug 29, 2003 at 12:44:00AM +0100, root@mauve.demon.co.uk wrote:

> > Of course it dowesn't.
> > The probability gets rather smaller as numbers go down, and bigger as
> > they go up.
> > With 2^128 bits, the chance of a a collision between 2^64
> > randomly chosen
> > pictures is 50%.
> > At 2^54 pictures, it's about one in a million, and at 2^34 (enough for
> > several pictures of everyone alive) one in a billion billion.
> > At more common numbers of pictures (say 2^14) it becomes vanishingly
> > unlikely for anyone to have two matching pictures (even with
> > several billion
> > archives)

> Be careful.  I remember discussing in probability class the liklyhood that
> two people in a room with N people have the same birthday.  N
> does not have
> to be anywhere close to 365 for your probability of a collision
> to be greater
> than 50%.  I forget what the exact number is but its less than 30.  The
> image problem sounds similar, depending on exactly how you phrase it.

	He's saying that with 2^128 possible hash values, you get a collision with
50% probability with roughly 2^64 pictures. Analogously for the birthday
paradox, with 365 possible birthdays (about 2^8), you get a collision with
50% probability with less than 30 people (about 2^5).

	Now does 5 really seem to be that much less than 8? His math is right and
so is yours. With 2^N possible values, all equally likely, you get a
collision with 50% probability in roughly 2^((N+1)/2).

	You'll note that the birthday paradox doesn't seem so suprising in
exponential notation. In the case of MD5, with
340,282,366,920,938,463,463,374,607,431,768,211,456 possible hashes, you get
a 50% chance of a collision in roughly
12,912,720,851,596,686,131 hashes. So that could seem fairly surprising when
you take it out of exponential notation too. (Just compare the lengths of
the two numbers.)

	DS


