Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267684AbTAHGM4>; Wed, 8 Jan 2003 01:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267685AbTAHGM4>; Wed, 8 Jan 2003 01:12:56 -0500
Received: from inpbox.inp.nsk.su ([193.124.167.24]:43976 "EHLO
	inpbox.inp.nsk.su") by vger.kernel.org with ESMTP
	id <S267684AbTAHGMz>; Wed, 8 Jan 2003 01:12:55 -0500
Date: Wed, 8 Jan 2003 12:17:43 +0600
From: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
Reply-To: D.A.Fedorov@inp.nsk.su
To: Pete Zaitcev <zaitcev@redhat.com>
cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: User mode drivers (Honest does not pay here ...)
In-Reply-To: <200301080419.h084JMT10615@devserv.devel.redhat.com>
Message-ID: <Pine.SGI.4.10.10301081203420.172134-100000@Sky.inp.nsk.su>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2003, Pete Zaitcev wrote:

> > I may be showing my ignorance here (won't be the first time) but this makes
> > me wonder if Linux could provide a way to do "user level drivers".
> 
> It is a question often asked in comp.os.linux.development.system.
> If performance penalties and security problems are no obstacle,

Perfomance is slightly higher since there are no extra switching to
kernel and back to user space and parameters passing.

> a lot of hardware can be serviced with a user mode driver, except
> one that requires interrupts to operate. There is no way to deliver
> an interrupt safely to the user mode, because a device specific
> deactivation or ack-ing must be performed before interrupts are

Some devices (ISA based, at least) does not requires immediate interrupt
acknowledge, they are can be serviced from the user space with 
interrupts and they do.

