Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271678AbRHQQAB>; Fri, 17 Aug 2001 12:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271683AbRHQP7v>; Fri, 17 Aug 2001 11:59:51 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:31879 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S271678AbRHQP7n>; Fri, 17 Aug 2001 11:59:43 -0400
Date: Fri, 17 Aug 2001 17:57:03 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>
cc: jes@trained-monkey.org, olivier.lebaillif@ifrsys.com, alan@redhat.com,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] dz.c 64 bit locking issues
In-Reply-To: <20010817164031.A6083@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010817175020.16692A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2001, Ralf Baechle wrote:

> > The dz.c driver has an instance where it does save_flags() to a 32 bit
> > type which isn't safe for 64 bit boxen.
> 
> It's safe because a MIPS only driver.

 Not necessarily.  It might be safe now, but there is a TURBOchannel
serial card with DZ11-compatible chipset that could be driven by the dz.c
code after a few tweaks.  And chances are someone will finish writing
support for TURBOchannel Alphas one day...

 The change is harmless anyway.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

