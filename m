Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbTFFMAH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 08:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbTFFMAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 08:00:07 -0400
Received: from med-gwia-02a.med.umich.edu ([141.214.93.150]:31785 "EHLO
	mail-02.med.umich.edu") by vger.kernel.org with ESMTP
	id S261196AbTFFMAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 08:00:06 -0400
Message-Id: <see04d33.063@mail-02.med.umich.edu>
X-Mailer: Novell GroupWise Internet Agent 6.0.2
Date: Fri, 06 Jun 2003 08:13:21 -0400
From: "Nicholas Berry" <nikberry@med.umich.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.5] Non-blocking write can block
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>> "Richard B. Johnson" <root@chaos.analogic.com> 06/05/03 03:15PM
>>>
>On Thu, 5 Jun 2003, Mike Fedyk wrote:

> On Wed, Jun 04, 2003 at 05:19:05PM -0700, Davide Libenzi wrote:
> > Besides the stupid name O_REALLYNONBLOCK, it really should be
different
> > from both O_NONBLOCK and O_NDELAY. Currently in Linux they both map
to the
> > same value, so you really need a new value to not break binary
compatibility.
>
> Hmm, wouldn't that be source and binary compatability?  If an app
used
> O_NDELAY and O_NONBLOCK interchangably, then a change to O_NDELAY
would
> break source compatability too.
>
> Also, what do other UNIX OSes do?  Do they have seperate semantics
for
> O_NONBLOCK and O_NDELAY?  If so, then it would probably be better to
change
> O_NDELAY to be similar and add another feature at the same time as
reducing
> platform specific codeing in userspace.
> -

>My Sun thinks that O_NDELAY = 0x04 and O_NONBLOCK = 0x80, FWIW.

AIX 4.3.3 O_NDELAY = 0x8000 and O_NONBLOCK = 0x04 FWTW.

Nik

>Cheers,
>Dick Johnson
>Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
>Why is the government concerned about the lunatic fringe? Think about
it.

