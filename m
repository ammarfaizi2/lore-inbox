Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129616AbRCAOpm>; Thu, 1 Mar 2001 09:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129619AbRCAOpd>; Thu, 1 Mar 2001 09:45:33 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:64928 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129616AbRCAOpT>; Thu, 1 Mar 2001 09:45:19 -0500
Date: Thu, 1 Mar 2001 15:24:26 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ingo Molnar <mingo@elte.hu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.2ac7
In-Reply-To: <Pine.LNX.4.30.0103011409100.2631-100000@elte.hu>
Message-ID: <Pine.GSO.3.96.1010301141854.15979E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2001, Ingo Molnar wrote:

> > > o	Handle broken PIV MP tables with a NULL ioapic
> >
> >  That's not a right fix. [...]
> 
> Maciej, it *is* the right fix. These are UP systems not SMP systems, but
> if we boot an SMP kernel then we find a (largely bogus) mptable during the
> scan.

 I disagree.  It's just a dirty hack and it obscures the APIC code even
more than it already is.  I propose to make it cleanly.  Please let me do
some code and we may get back to the discussion then. 

> Any BIOS of a real SMP box that is so blatantly broken to specify a NULL
> ioapic in the mptable deserves SMP mode being disabled altogether.

 I suppose such BIOS doesn't exist and isn't going to.  An SMP
configuration with no I/O APIC is legal from the hw point of view though
and it's sane (modulo errata), even if not permitted by the MPS.  We may
handle it for free and we will handle UP systems with an MP-table and no
APIC automatically as well.

> lets not overcomplicate things.

 Sure -- I just want to simplify them. :-)

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

