Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbSKHMRk>; Fri, 8 Nov 2002 07:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261688AbSKHMRk>; Fri, 8 Nov 2002 07:17:40 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:55761 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S261295AbSKHMRj>; Fri, 8 Nov 2002 07:17:39 -0500
Date: Fri, 8 Nov 2002 13:21:27 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Zwane Mwaikambo <zwane@holomorphy.com>
cc: Mikael Pettersson <mikpe@csd.uu.se>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][2.5-AC] Forced enable/disable local APIC
In-Reply-To: <Pine.LNX.4.44.0211071639090.27141-100000@montezuma.mastecende.com>
Message-ID: <Pine.GSO.3.96.1021108131625.3217B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2002, Zwane Mwaikambo wrote:

> > No. Read what I wrote: if cpu_has_apic is false, the code drops into
> > the "try the hard way by messing with the APICBASE MSR". Your "force"
> > goto bypasses the CPU checks, which are there to ensure that the CPU
> > actually _has_ an APICBASE MSR.
> 
> My mistake, i misread.
>  
> > I still see no reason at all for the force.
> 
> I agree, in which case the first patch should make everyone happy. If Alan 
> doesn't take it for his next release i'll resend.

 Well, the "lapic" option should override the DMI setting, not the
APICBASE availability check.  Anyway, I don't insist on this that much --
while I think consistency is good, none of the "*apic" options are
actually a necessity for me.  If one needs the option, one may still cook
an appropriate patch oneself. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

