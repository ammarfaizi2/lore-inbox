Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbRBHQRC>; Thu, 8 Feb 2001 11:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129253AbRBHQQx>; Thu, 8 Feb 2001 11:16:53 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:55968 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129057AbRBHQQg>; Thu, 8 Feb 2001 11:16:36 -0500
Date: Thu, 8 Feb 2001 17:05:58 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
        mingo@redhat.com, hpa@transmeta.com
Subject: Re: [PATCH] Re: UP APIC reenabling vs. cpu type detection o
In-Reply-To: <14E3B9B878C2@vcnet.vc.cvut.cz>
Message-ID: <Pine.GSO.3.96.1010208165851.29177P-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001, Petr Vandrovec wrote:

> So it came to my mind - why (on K7 we easy can, as counter has 48 bits)
> we do not reload NMI watchdog in each timer interrupt with 5sec timeout,
> and if we receive even one NMI, we are locked up? It should increase
> performance, as we'll do same number of MSR writes anyway (100/s), but
> we will not receive any NMI during normal operation, so we save time
> spent in processing this. Or do I miss something?

 I guess it's the external watchdog heritage.  The code is common for both
kinds of the watchdog at the moment.  It might get separated, I suppose. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
