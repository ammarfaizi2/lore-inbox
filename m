Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289080AbSAOLo6>; Tue, 15 Jan 2002 06:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289115AbSAOLot>; Tue, 15 Jan 2002 06:44:49 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:5577 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S289080AbSAOLok>; Tue, 15 Jan 2002 06:44:40 -0500
Date: Tue, 15 Jan 2002 12:44:30 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Keith Owens <kaos@ocs.com.au>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with ServerWorks CNB20LE and lost interrupts 
In-Reply-To: <31989.1011042290@ocs3.intra.ocs.com.au>
Message-ID: <Pine.GSO.3.96.1020115123935.24748A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002, Keith Owens wrote:

> > The "noapic" option should probably get removed -- it was meant as a
> >debugging aid (as many of the "no*" options) at the early days of I/O APIC
> >support, I believe...  Now the support is pretty stable.
> 
> Intel 440GX chipsets hang during SCSI probe with UP kernels unless you
> use noapic.  It works with SMP but many installers use UP kernels.
> Removing noapic will break install on all 440GX machines, there are a
> lot of them out there.

 Now, is that a chipset problem or a firmware (MP table) one?  If the
former, we should code a workaround triggered by the chipset's PCI ID, so
the I/O APIC path works, otherwise vendors should fix their firmware.  For
UP systems a simple possibility is to remove the MP table altogether if
it's too hard to fix -- it is not needed at all. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

