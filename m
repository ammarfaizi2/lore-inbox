Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317066AbSG1Sti>; Sun, 28 Jul 2002 14:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317072AbSG1Sti>; Sun, 28 Jul 2002 14:49:38 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:57333 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317066AbSG1Sti>; Sun, 28 Jul 2002 14:49:38 -0400
Subject: Re: Looking for links: Why Linux Doesn't Page Kernel Memory?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Phillips <phillips@arcor.de>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Russell Lewis <spamhole-2001-07-16@deming-os.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <E17YcPU-00028D-00@starship>
References: <1027712005.14773.12.camel@irongate.swansea.linux.org.uk>
	<3D418DFD.8000007@deming-os.org> <16918.1027787098@redhat.com> 
	<E17YcPU-00028D-00@starship>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 28 Jul 2002 21:07:36 +0100
Message-Id: <1027886856.842.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-28 at 01:59, Daniel Phillips wrote:
> On Saturday 27 July 2002 18:24, David Woodhouse wrote:
> > ...Introduce it 
> > slowly, adding it a little at a time like we did SMP, and like we _should_ 
> > have done preemption.
> 
> I'll bite.  How should we have done preemption?

By defaulting pre-emption off globally and working from the inside
adding pre-empt enable/disable pairs around blocks of code as they were
checked. Like the smp lock work but inside out.

That way egthe NE2000 driver might still work properly now, and be
working until its fixed.

