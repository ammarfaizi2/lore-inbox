Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277251AbRJDX06>; Thu, 4 Oct 2001 19:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277265AbRJDX0k>; Thu, 4 Oct 2001 19:26:40 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:25009 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S277251AbRJDX02>; Thu, 4 Oct 2001 19:26:28 -0400
Date: Thu, 4 Oct 2001 19:26:45 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: mingo@elte.hu, jamal <hadi@cyberus.ca>, linux-kernel@vger.kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>, netdev@oss.sgi.com,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Simon Kirby <sim@netnation.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Message-ID: <20011004192645.A20389@redhat.com>
In-Reply-To: <20011004174945.B18528@redhat.com> <309455016.1002241234@[195.224.237.69]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <309455016.1002241234@[195.224.237.69]>; from linux-kernel@alex.org.uk on Fri, Oct 05, 2001 at 12:20:34AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2001 at 12:20:34AM +0100, Alex Bligh - linux-kernel wrote:
> Rather than bugging the author of the driver card, we've actually
> been trying to fix it, down to rewriting the firmware. So for
> this purpose I/we am/are the driver maintainer thanks. However,
> there are limitations like bus speed which mean that in practice
> if we receive a large enough number of small packets each second,
> the box will saturate.

Not if the driver has a decent irq mitigation schema and uses the 
hw flow control + NAPI bits.

> Not sure this required jumping down my throat.

Frankly I'm sick of this entire discussion where people claim that no 
form of interrupt throttling is ever needed.  It's an emergency measure 
that is needed under some circumstances as very few drivers properly 
protect against this kind of DoS.  Drivers that do things correctly will 
never trigger the hammer.  Plus it's configurable.  If you'd bothered to 
read and understand the rest of this thread you wouldn't have posted.

		-ben
