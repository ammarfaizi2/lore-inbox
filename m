Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290858AbSARWj6>; Fri, 18 Jan 2002 17:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290859AbSARWjs>; Fri, 18 Jan 2002 17:39:48 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:56252 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S290858AbSARWji>; Fri, 18 Jan 2002 17:39:38 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [PATCH] IBM Lanstreamer bugfixes
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFC5DE810D.63923974-ON85256B45.007C4216@raleigh.ibm.com>
From: "Kent E Yoder" <yoder1@us.ibm.com>
Date: Fri, 18 Jan 2002 16:39:36 -0600
X-MIMETrack: Serialize by Router on D04NM109/04/M/IBM(Release 5.0.9 |November 16, 2001) at
 01/18/2002 05:39:38 PM,
	Serialize complete at 01/18/2002 05:39:38 PM
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >   actually I should be using spin_lock_irqsave() in open() and close()
> > since the lock is taken inside the interrupt function, no?
> 
> Correct - which might explain some of your other delays curing lockups

  Hmmm..  i wish it did.  Unfortunately the only non irq saved calls to 
spin_lock are in the open and close functions, my lock call in xmit is irq 
saved.  These should be changed obviously, but I haven't seen the box lock 
up during open or close...

Kent

