Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268031AbTAIWVM>; Thu, 9 Jan 2003 17:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268032AbTAIWVL>; Thu, 9 Jan 2003 17:21:11 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:53676 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S268031AbTAIWVF> convert rfc822-to-8bit; Thu, 9 Jan 2003 17:21:05 -0500
content-class: urn:content-classes:message
Subject: RE: detecting hyperthreading in linux 2.4.19
Date: Thu, 9 Jan 2003 14:29:41 -0800
Message-ID: <E88224AA79D2744187E7854CA8D9131DA5CE5B@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: detecting hyperthreading in linux 2.4.19
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcK4KqHaqD3e1SQdEdeNCQBQi+Bs2AAAM4qAAAB38IA=
From: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
To: <lunz@falooley.org>, <jamesclv@us.ibm.com>, <linux-kernel@vger.kernel.org>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Schlobohm, Bruce" <bruce.schlobohm@intel.com>
X-OriginalArrivalTime: 09 Jan 2003 22:29:41.0751 (UTC) FILETIME=[9A5BD070:01C2B82E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,
I have posted a patch for this on LKML. Please have look at:
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0301.0/1886.html
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0301.0/1887.html

It should solve the problem you are trying to solve.

Nitin

> -----Original Message-----
> From: Jason Lunz [mailto:lunz@falooley.org]
> Sent: Thursday, January 09, 2003 1:57 PM
> To: linux-kernel@vger.kernel.org
> Subject: Re: detecting hyperthreading in linux 2.4.19
> 
> jamesclv@us.ibm.com said:
> > I don't know of any way to do this in userland.  The whole point is
> > that the sibling processors are supposed to look like real ones.
> 
> That's unfortunately not always true. I'm writing a program that will
> run on a system that will be doing high-load routing. Testing has
shown
> that we get better performance when binding each NIC's interrupts to a
> separate physical processor using /proc/irq/*/smp_affinity (especially
> when all the interrupts would hit the first CPU, another problem i've
> yet to address). That only works for real processors, though, not
> HT siblings.
> 
> I'm writing a program to run on machines of unknown (by me)
> configuration, that will spread out the NIC interrupts appropriately.
> So userspace needs to know the difference, at least until interrupts
can
> be automatically distributed by the kernel in a satisfactory way.
> 
> Jason
