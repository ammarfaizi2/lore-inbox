Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280161AbRJaLcu>; Wed, 31 Oct 2001 06:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280162AbRJaLck>; Wed, 31 Oct 2001 06:32:40 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:47291 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S280161AbRJaLcb>; Wed, 31 Oct 2001 06:32:31 -0500
Date: Wed, 31 Oct 2001 12:31:30 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] making the printk buffer bigger 
In-Reply-To: <3709761319.1004437141@mbligh.des.sequent.com>
Message-ID: <Pine.GSO.3.96.1011031122155.10781A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2001, Martin J. Bligh wrote:

> I don't just want it for development, I believe in capturing my boot messages 
> all the time. If they're not visible, why bother printing them?

 Assuming the code is correct at one stage, what do you need detailed
debug data, for? 

> The correct solution is probably to either size it dynamically, or have a
> seperate boot time buffer that we throw away afterwards. But for the 
> sake of another 48Kb on machines with 2 - 16Gb of RAM, it's not worth
> coding it, testing it, and risking the change.

 There are 4MB systems out there, too.  Sizing the buffer dynamically is
probably OK.

> PS. Alan's solution was to turn off half the garbage that gets printed on
> boot, which would work too. Especially half the stuff from the mps tables,
> which we throw in the bin 2 nanoseconds after printing it. We could
> turn off APIC_DEBUG by default, which would kill all the Dprintk's as
> far as I can see ....

 The MPS tables are tiny comparing to other stuff, I'm told.  Switching
them to KERN_DEBUG is a good idea at this stage; as is probably undefining
APIC_DEBUG.  Anyway, I'm told APIC debug messages are small comparing to
ones output by certain other subsystems. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

