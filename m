Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268164AbTBNKoq>; Fri, 14 Feb 2003 05:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268346AbTBNKoq>; Fri, 14 Feb 2003 05:44:46 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:47577 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S268164AbTBNKop>; Fri, 14 Feb 2003 05:44:45 -0500
Date: Fri, 14 Feb 2003 11:54:34 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: Pavel Machek <pavel@suse.cz>, John Levon <levon@movementarian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Switch APIC (+nmi, +oprofile) to driver model
In-Reply-To: <15948.50644.705291.922086@kim.it.uu.se>
Message-ID: <Pine.GSO.3.96.1030214115026.666C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2003, Mikael Pettersson wrote:

> My goal was to not change any behaviour from our current code, and from
> what I can tell, our current code does not support PM suspend and resume
> for old external-local-APIC machines. (They're mostly 486 MPs, right?)

 Both i486 and Pentium (typically for quad support, etc.).

> The suspend/resume procedures only work on P6/K7 and up. There's a
> bug there in that we may try to run the suspend on a UP P5 with enabled
> local APIC, which won't work. So far, no one seems to have noticed :->

 OK, but then the question is: are the following calls:

+	driver_register(&local_apic_driver);
+	return sys_device_register(&device_local_apic);

for suspend/resume exclusively?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

