Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266646AbUBGGkP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 01:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266650AbUBGGkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 01:40:15 -0500
Received: from mxsf30.cluster1.charter.net ([209.225.28.230]:60690 "EHLO
	mxsf30.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S266646AbUBGGkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 01:40:08 -0500
Date: Sat, 7 Feb 2004 01:39:06 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [ACPI] acpi problem with nforce motherboards and ethernet
Message-ID: <20040207063906.GA2188@forming>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <402298C7.5050405@wanadoo.es> <40229D2C.20701@blue-labs.org> <4022B55B.1090309@wanadoo.es> <20040205154059.6649dd74.akpm@osdl.org> <Pine.LNX.4.55.0402070021210.12260@jurand.ds.pg.gda.pl> <20040207035018.33ce01dc.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040207035018.33ce01dc.ak@suse.de>
X-Editor: GNU Emacs 21.1
X-Operating-System: Debian GNU/Linux 2.6.3-rc1 i686
X-Uptime: 01:33:22 up 4 min,  3 users,  load average: 2.09, 1.10, 0.45
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Josh McKinney <forming@charter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On approximately Sat, Feb 07, 2004 at 03:50:18AM +0100, Andi Kleen wrote:
> On Sat, 7 Feb 2004 00:33:04 +0100 (CET)
> "Maciej W. Rozycki" <macro@ds2.pg.gda.pl> wrote:
> 
> 
> >  That's not the right fix.  There's a bug in Linux's ACPI IRQ setup as
> > I've discovered by comparing the code to the spec.  Here's a patch I sent
> > in December both to the LKML and the ACPI maintainer.  The feedback from
> > the list was positive, but the maintainer didn't bother to comment.
> 
> Thanks. I added the patch to the x86-64 sources and it indeed seems to fix
> the Nforce3.
> 

I tried the patch against 2.6.3-rc1 and it doesn't seem to fix
anything, timer is still on XT-PIC.  This is on a A7N8X Deluxe rev2,
nforce2.

           CPU0       
  0:     524366          XT-PIC  timer
  1:       1727    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          1    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 14:        913    IO-APIC-edge  ide0
 15:      22792    IO-APIC-edge  ide1
 19:      23559   IO-APIC-level  nvidia
 20:      52452   IO-APIC-level  ohci_hcd, eth0
 21:          0   IO-APIC-level  ehci_hcd, NVidia nForce2
 22:        354   IO-APIC-level  ohci_hcd
NMI:          0 
LOC:     524223 
ERR:          0
MIS:          0


-- 
Josh McKinney		     |	Webmaster: http://joshandangie.org
--------------------------------------------------------------------------
                             | They that can give up essential liberty
Linux, the choice       -o)  | to obtain a little temporary safety deserve 
of the GNU generation    /\  | neither liberty or safety. 
                        _\_v |                          -Benjamin Franklin
