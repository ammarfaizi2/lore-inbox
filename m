Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288870AbSANOWf>; Mon, 14 Jan 2002 09:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289250AbSANOWZ>; Mon, 14 Jan 2002 09:22:25 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:59065 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S289175AbSANOWN>; Mon, 14 Jan 2002 09:22:13 -0500
Date: Mon, 14 Jan 2002 15:19:00 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
cc: Jim Studt <jim@federated.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with ServerWorks CNB20LE and lost interrupts
In-Reply-To: <Pine.LNX.4.33.0201141541540.9075-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.GSO.3.96.1020114150024.16706C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Zwane Mwaikambo wrote:

> You may have noticed the great deal of "hacks" which people have put into
> the kernel over the years to get it to work with the imperfect world of
> hardware. It makes you wonder wether we should waste our time supporting

 Well, I added a few trivial firmware workarounds myself, but the question
is how much we can obfuscate the kernel before it gets to the point of
insanity and how much effort one should put in them before deciding it's
not worth the trouble.  One-liners are usually fine, but is anything more
complex?  And I/O APIC routing table bugs are quite hopeless -- you need
to know the physical layout of traces on a given PCB before even trying to
do anything useful. 

> broken hardware... Then again if we didn't we'd only run on 0.1% of the
> boxes out there ;) But... i'm in no way advocating for adding more
> kludges.

 SMP hardware is mostly targetted to the server market which seems to care
of Linux due to many customers running it.  If they ask vendors for fixes
or choose another brand (surprisingly enough, there are vendors that can
get their MP tables right), the vendors will start fixing bugs.  If we
work them around, they will not, as there won't be a reason to. 

 The "noapic" option should probably get removed -- it was meant as a
debugging aid (as many of the "no*" options) at the early days of I/O APIC
support, I believe...  Now the support is pretty stable.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

