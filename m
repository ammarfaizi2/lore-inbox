Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbSKTPng>; Wed, 20 Nov 2002 10:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261375AbSKTPng>; Wed, 20 Nov 2002 10:43:36 -0500
Received: from fmr01.intel.com ([192.55.52.18]:28902 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S261371AbSKTPnc>;
	Wed, 20 Nov 2002 10:43:32 -0500
Message-ID: <F2DBA543B89AD51184B600508B68D4000FDD858E@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>
Cc: Steffen Persvold <sp@scali.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       linux-kernel@vger.kernel.org
Subject: RE: [BUG?] Xeon with HyperThreading and linux-2.4.20-rc2
Date: Wed, 20 Nov 2002 07:50:34 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As Hugh pointed out, the MPS table should report the physical processors
only even if HT is enabled. The major reason is to support legacy OSes that
don't support HT well. If the BIOS has an option for you to enable/disable
HT, then please use it. 

Jun

> -----Original Message-----
> From: Arjan van de Ven [mailto:arjanv@redhat.com]
> Sent: Wednesday, November 20, 2002 5:04 AM
> To: Hugh Dickins
> Cc: Steffen Persvold; Jun Nakajima; Arjan van de Ven; linux-
> kernel@vger.kernel.org
> Subject: Re: [BUG?] Xeon with HyperThreading and linux-2.4.20-rc2
> 
> On Wed, Nov 20, 2002 at 12:53:04PM +0000, Hugh Dickins wrote:
> >
> > I know too little to comment definitively, but it's my understanding
> > that a dual HT machine should only show 2 processors in its MP table,
> > their siblings only appearing through analysis of the ACPI tables.
> >
> > Whether it's that your MP table has been wrongly set up, or that
> > you've really been given 4 processors when you only asked for 2
> > (sue your supplier!), I cannot say.  I've copied Jun at Intel
> > and Arjan at RedHat, and hope they can shed more light on this.
> 
> Linux has zero problem with a sane MP table that lists all
> CPU's. Intel normally seems to recommend against it (maybe N3.51 doesn't
> like it or so) but it's all fair as far as I'm concerned.
> The bios is supposed to offer you a choice
> to disable hyperthreading, use that ;)
> 
> Greetings,
>    Arjan van de Ven
> 
> 
> --
> But when you distribute the same sections as part of a whole which is a
> work
> based on the Program, the distribution of the whole must be on the terms
> of
> this License, whose permissions for other licensees extend to the entire
> whole,
> and thus to each and every part regardless of who wrote it. [sect.2 GPL]
