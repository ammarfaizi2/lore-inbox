Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262189AbULRCOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbULRCOq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 21:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262815AbULRCOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 21:14:46 -0500
Received: from ppp-202.176.140.157.revip.asianet.co.th ([202.176.140.157]:38596
	"EHLO mhfl2.mhf.dom") by vger.kernel.org with ESMTP id S262189AbULRCOn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 21:14:43 -0500
From: Michael Frank <mhf@berlios.de>
To: Pavel Machek <pavel@ucw.cz>, Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [SoftwareSuspend-devel] 2.6 Suspend PM issues
Date: Sat, 18 Dec 2004 10:14:29 +0800
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       softwaresuspend-devel@lists.berlios.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200412171315.50463.mhf@berlios.de> <1103263067.19280.4.camel@desktop.cunninghams> <20041217092642.GH25573@elf.ucw.cz>
In-Reply-To: <20041217092642.GH25573@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412181014.30998.mhf@berlios.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 December 2004 17:26, Pavel Machek wrote:
> Hi!
>
> > > By what was discussed wrt ALSA issue I gather that you still resume
> > > _all_ drivers after doing the atomic copy?
> > >
> > > As explained earlier this year, if this is the case, it is firstly
> > > unacceptable as it will result in loss of data in many applications and
> > > secondly very clumsy.
> > >
> > > Example With 2.4 OK, with 2.6 It would fail:
> > > A datalogger connected to a seral port of a notebook in the field. Data
> > > transfer in progress which can be put on hold bo lowering RTS (HW
> > > handshake) but _cannot_ be restarted. Battery low, must suspend to
> > > change battery, upon resume transfer can continue.
> > >
> > > Will this be taken care of?
>
> Driver will get enough info in its resume routine ("hey, it is resume,
> but it is only resume after atomic copy"), so it can ignore the resume
> if it really needs to.

Each driver has to make the decision when to ignore resume? that would add a 
lot of bloat as well as lots of work to implement and test the changes for 
100s of drivers...

Please consider the practical implications of your proposal and you may find 
that this really should be handled in a centralized manner.

>
> But this is 2.6.11 material.

Fine.

 Michael
