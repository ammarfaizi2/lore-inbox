Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263091AbVCQP1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263091AbVCQP1S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 10:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263094AbVCQP1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 10:27:18 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:15298 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263091AbVCQP1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 10:27:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=koM1f3ODKJU01rMXic1H5Nu9pJNrx7CxwILPUGE2Duacy1i7e5w451ASzGIq3+cY51fvwJayI67OLkAZEVJEmHdTWbkTK7ozP6Gz+Pua/KGEUPLFQOL0gbY+Fqcb13TOt0SZI+1uTvYBExFvnwUGJAjYe21GrDlhkwI5sUuK79U=
Message-ID: <5a2cf1f605031707277205137a@mail.gmail.com>
Date: Thu, 17 Mar 2005 16:27:12 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
Reply-To: jerome lacoste <jerome.lacoste@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: enabling IOAPIC on C3 processor?
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1111006101.21604.9.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <5a2cf1f6050315040956a512a6@mail.gmail.com>
	 <1110918157.17931.18.camel@mindpipe>
	 <5a2cf1f60503160711137dbff3@mail.gmail.com>
	 <1111006101.21604.9.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2005 15:48:21 -0500, Lee Revell <rlrevell@joe-job.com> wrote:
> On Wed, 2005-03-16 at 16:11 +0100, jerome lacoste wrote:
> > On Tue, 15 Mar 2005 15:22:36 -0500, Lee Revell <rlrevell@joe-job.com> wrote:
> > > On Tue, 2005-03-15 at 13:09 +0100, jerome lacoste wrote:
> > > > I have a VIA Epia M10000 board that crashes very badly (and pretty
> > > > often, especially when using DMA). I want to fix that.
> > > >
> > >
> > > Are the crashes associated with any particular workload or device?  My
> > > M6000 works perfectly.
> > >
> > > The one big problem I had with is is the VIA Unichrome XAA driver had a
> > > FIFO related bug that caused it to stall the PCI bus, delaying
> > > interrupts for tens of ms unless "Option NoAccel" was used.
> > >
> > > This bug was fixed over 6 months ago though.
> >
> > It crashes my box within minutes if not seconds when using mythtv
> > (tuner using ivtv driver) while using my network card. If I disable
> > DMA on the disk and don't use my card, it's much more stable (several
> > hours without problem).
> >
> 
> Well, you might have better luck capturing the Oops with kdb.  At the
> very least it might drop you into the debugger instead of locking up the
> machine.

It doesn't.
I patched and recompiled my kernel and made sure the
/proc/sys/kernel/kdb is set to 1.
Machine dies with no kdb started.

I guess I just need for VIA to wake up now, right? No more bullets in my gun?

Jerome
