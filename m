Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319281AbSIEXAc>; Thu, 5 Sep 2002 19:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319277AbSIEXAc>; Thu, 5 Sep 2002 19:00:32 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:62990 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S319281AbSIEXAW>; Thu, 5 Sep 2002 19:00:22 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200209052304.g85N4q023716@devserv.devel.redhat.com>
Subject: Re: Linux 2.4.20-pre5-ac3
To: tadavis@lbl.gov (Thomas Davis)
Date: Thu, 5 Sep 2002 19:04:52 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3D77E1C2.560B6646@lbl.gov> from "Thomas Davis" at Sep 05, 2002 03:59:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Sep  5 12:11:21 localhost cardmgr[854]: executing: './ide start hde'
> > > Sep  5 12:11:21 localhost kernel: hde: bad special flag: 0x03
> > >
> > > [locked tight]
> > 
> > On the end of the insert or on the removal ?
> 
> just after the insert.

Does pre4-ac do the same ? There is a change or two in the irq masking on
the probes and this does sound like an IRQ jam up. (You might find removing
the card unjams the kernel - depends)

I've tried duplicating the problem here loading an IDE PCMICA card and
I get the usual behaviour - it hangs briefly then continues happily. The
hang needs looking at - it seems we may have some IRQ handling issues 
there anyway
