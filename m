Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265697AbUJVTQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbUJVTQd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 15:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUJVTIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 15:08:24 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:37796
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S265697AbUJVTGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 15:06:52 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U9.3
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: "K.R. Foley" <kr@cybsft.com>
Cc: Mark_H_Johnson@raytheon.com, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
In-Reply-To: <41795653.6020802@cybsft.com>
References: <OF7FC21EAE.3A2E362A-ON86256F35.0066D568-86256F35.0066D58B@raytheon.com>
	 <41795653.6020802@cybsft.com>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 22 Oct 2004 20:58:48 +0200
Message-Id: <1098471528.3306.4.camel@thomas>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-22 at 13:49 -0500, K.R. Foley wrote:
> Mark_H_Johnson@raytheon.com wrote:
> >>i have released the -U9.3 Real-Time Preemption patch, ...
> >>
> > 
> > It is getting hard to keep up with the updates....
> > 
> > This version built OK and since I noticed it includes fixes for the
> > parallel port, I added that back to my configuration and built / booted
> > without any problems. I still see the BUG from:
> > 
> > Oct 22 12:27:50 dws77 kernel: 8139too Fast Ethernet driver 0.9.27
> > Oct 22 12:27:50 dws77 kernel: eth0: RealTek RTL8139 at 0xdc00,
> > 00:50:bf:39:11:fc, IRQ 11
> > Oct 22 12:27:50 dws77 kernel: BUG: atomic counter underflow at:
> > Oct 22 12:27:50 dws77 kernel:  [<c02b8f88>] qdisc_destroy+0x98/0xa0 (12)
> > 
> > I saw the messages about fixes for the other network drivers, but
> > don't forget this one.
> 
> I still get this also. This is not fixed by the network driver fix, but 
> I don't think it was expected to be.

No, the fix was for the missing pci shutdown in tulip.

This one is something weird, which has to do with kuzdu triggered
load,unload,reload of a module. Not sure what happens there. I would
need more detailed information. Maybe enabling some debug print of the
card driver would reviel whats going on.

tglx


