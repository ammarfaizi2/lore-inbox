Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVFNWpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVFNWpg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 18:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVFNWpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 18:45:36 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:49401 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261389AbVFNWpa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 18:45:30 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>
In-Reply-To: <20050614185448.GA26731@elte.hu>
References: <20050608112801.GA31084@elte.hu> <42AF20F9.20704@cybsft.com>
	 <20050614185448.GA26731@elte.hu>
Content-Type: text/plain
Organization: MontaVista
Date: Tue, 14 Jun 2005 15:45:22 -0700
Message-Id: <1118789122.10106.1.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-14 at 20:54 +0200, Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> > Ingo Molnar wrote:
> > >i have released the -V0.7.48-00 Real-Time Preemption patch, which can be 
> > >downloaded from the usual place:
> > 
> > Ingo,
> > 
> > I just got this soft lock with -RT-2.6.12-rc6-V0.7.48-32 on my dual 
> > 2.6G Xeon W/HT. Not sure what causes it. Just typing away and its like 
> > a key sticks. It keeps printing the same key, even if I use the mouse 
> > to change focus the typing follows the focus, and then it finally 
> > hangs.
> 
> ah ... accidentaly had debug_direct_keyboard = 1 in kernel/irq/handle.c.  
> Change it to 0 & recompile, or pick up the -48-33 patch i just uploaded.

I think your putting to many raw_local_irq_disable calls back in .. Are
you planning to do an audit at some point ?

Daniel



