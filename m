Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130335AbRARRTo>; Thu, 18 Jan 2001 12:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130454AbRARRTf>; Thu, 18 Jan 2001 12:19:35 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:41207 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S130335AbRARRT1>; Thu, 18 Jan 2001 12:19:27 -0500
Date: Thu, 18 Jan 2001 17:14:41 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Tuukka Toivonen <tutoivon@mail.student.oulu.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: patch: enabling RDPMC: bit 8 in CR4 (PCE)
In-Reply-To: <Pine.SGI.4.21.0101181735430.3651579-100000@paju.oulu.fi>
Message-ID: <Pine.GSO.3.96.1010118165749.25313A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2001, Tuukka Toivonen wrote:

> I suppose that if the CPU has MMX, then it's ok to write 1 in PCE
> bit. This should be valid for Intel CPUs, but it's certainly possible that
> there are non-Intel CPUs that have MMX but not RDPMC. However, I'd guess
> that writing 1 to PCE bit doesn't do any harm.

 It's not completely OK to write 1 to cr4.pce as you get a GP fault if a
CPU does not support it.  However, you may handle the exception yourself
and enable rdpmc unconditionally, i.e. with no feature test (Intel states
cr4.pce is model-specific anyway) -- hopefully no vendor overloads the
cr4.pce bit.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
