Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268356AbTBNLWI>; Fri, 14 Feb 2003 06:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268361AbTBNLWI>; Fri, 14 Feb 2003 06:22:08 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:29914 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S268356AbTBNLWH>; Fri, 14 Feb 2003 06:22:07 -0500
Date: Fri, 14 Feb 2003 12:32:03 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: Pavel Machek <pavel@suse.cz>, John Levon <levon@movementarian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Switch APIC (+nmi, +oprofile) to driver model
In-Reply-To: <15948.53826.813484.291297@kim.it.uu.se>
Message-ID: <Pine.GSO.3.96.1030214122908.2266D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2003, Mikael Pettersson wrote:

>  >  OK, but then the question is: are the following calls:
>  > 
>  > +	driver_register(&local_apic_driver);
>  > +	return sys_device_register(&device_local_apic);
>  > 
>  > for suspend/resume exclusively?
> 
> Yes.

 OK, then.

> We could register the device also in other cases (!PM, SMP)
> but the methods would then be nullified and we'd have a device
> node with a name but no operations. I could do that, I just
> think it's pointless.

 Agreed if the interface is not going to be extended further, i.e. the
intent is to cover PM-capable devices only.

 I'd prefer the discrete APIC support not to get broken accidentally as
such systems are rare thus testing is limited. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

