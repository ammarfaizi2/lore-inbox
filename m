Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268571AbRGYNfb>; Wed, 25 Jul 2001 09:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268573AbRGYNfV>; Wed, 25 Jul 2001 09:35:21 -0400
Received: from kotiposti.reimari.net ([212.63.10.60]:46823 "EHLO
	smtp2.koti.soon.fi") by vger.kernel.org with ESMTP
	id <S268571AbRGYNfH>; Wed, 25 Jul 2001 09:35:07 -0400
From: "M. Tavasti" <tawz@nic.fi>
To: Ketil Froyn <ketil@froyn.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Select with device and stdin not working
In-Reply-To: <Pine.LNX.4.30.0107251550370.20050-100000@pccn3.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: 25 Jul 2001 16:35:05 +0300
In-Reply-To: Ketil Froyn's message of "Wed, 25 Jul 2001 15:53:34 +0200 (CEST)"
Message-ID: <m2snflm8s6.fsf@akvavitix.vuovasti.com>
X-Mailer: Gnus v5.6.45/XEmacs 21.1 - "Capitol Reef"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Ketil Froyn <ketil@froyn.com> writes:

> > while(1) {
> >         FD_ZERO(&rfds);
> >         FD_SET(fd,&rfds);
> >         FD_SET(fileno(stdin),&rfds);
> >         if( select(fd+1, &rfds, NULL, NULL, NULL  ) > 0) {
(Lines removed)
> > }
> 
> It looks like you are sending the original fd_set to select. Remember that
> it is modified in place. 

But one would at least expect FD_ZERO() to really clean up rfds, and
after it FD_SET() is used again, for every call of select().  And this
code works fine in 2.0 kernels, and also with 2.2 and 2.4 if I'm using
named pipe and stdin. Therefore I have strong belief problem is not
usage of select() but something else.

-- 
M. Tavasti /  tawz@nic.fi  /   +358-40-5078254
