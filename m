Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267361AbUJGJGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267361AbUJGJGX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 05:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269762AbUJGJGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 05:06:22 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:10368 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S269763AbUJGJEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 05:04:51 -0400
Date: Thu, 7 Oct 2004 11:04:50 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm2: compile error in irq.c
Message-ID: <20041007110450.4fcf9acd@phoebee>
In-Reply-To: <20041007094404.30a6feb3@phoebee>
References: <20041007094404.30a6feb3@phoebee>
X-Mailer: Sylpheed-Claws 0.9.12cvs53 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.7-rc2-mm2 i686 Intel(R) Pentium(R) 4
 CPU 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__7_Oct_2004_11_04_50_+0200_as9pVeRngUZo2OSw"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__7_Oct_2004_11_04_50_+0200_as9pVeRngUZo2OSw
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 7 Oct 2004 09:44:04 +0200
Martin Zwickel <martin.zwickel@technotrend.de> bubbled:

> Hi there!
> 
> I don't know if someone already made a patch that's working, so I'm
> posting the compile error here:
> 
> arch/i386/kernel/irq.c:203: error: redefinition of `is_irq_stack_ptr'
> include/asm/hardirq.h:25: error: `is_irq_stack_ptr' previously defined
> here arch/i386/kernel/irq.c: In function `is_irq_stack_ptr':
> arch/i386/kernel/irq.c:207: error: `hardirq_stack' undeclared (first
> use in this function) arch/i386/kernel/irq.c:207: error: (Each
> undeclared identifier is reported only once
> arch/i386/kernel/irq.c:207: error: for each function it appears in.)
> arch/i386/kernel/irq.c:210: error: `softirq_stack' undeclared (first
> use in this function) make[1]: *** [arch/i386/kernel/irq.o] Error 1
> make: *** [arch/i386/kernel] Error 2
> 

Hmm, I made an "#ifdef CONFIG_4KSTACKS" around the is_irq_stack_ptr() in
irq.c because the hardirq_stack() is only defined if the 4K-STACKS are
selected.

Is this the correct way?

-- 
MyExcuse:
Post-it Note Sludge leaked into the monitor.

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature=_Thu__7_Oct_2004_11_04_50_+0200_as9pVeRngUZo2OSw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBZQaymjLYGS7fcG0RAp2zAJ0fcoa1yX6GfyRGoN6kY+Z8ADsd7gCaAgSl
f8Gpi6nhHdS7a6XXQ9mSWnQ=
=yTuR
-----END PGP SIGNATURE-----

--Signature=_Thu__7_Oct_2004_11_04_50_+0200_as9pVeRngUZo2OSw--
