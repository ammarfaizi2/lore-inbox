Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129872AbQKUTjy>; Tue, 21 Nov 2000 14:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131002AbQKUTjo>; Tue, 21 Nov 2000 14:39:44 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:56982 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129872AbQKUTjg>; Tue, 21 Nov 2000 14:39:36 -0500
Date: Tue, 21 Nov 2000 20:08:43 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Johannes Erdfelt <johannes@erdfelt.com>,
        Ingo Molnar <mingo@chiara.elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0test11-ac1
In-Reply-To: <E13yITj-00051Z-00@the-village.bc.nu>
Message-ID: <Pine.GSO.3.96.1001121195742.28403E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2000, Alan Cox wrote:

> Quite a few dual pentium socket 7 boards report dual cpu and apic in the 
> MP table regardless of the capabilities of the CPU installed. Its apparently
> legal to do so. There is an apic capability flag that should be tested before

 It's not legal -- the MPS is very explicit the MP-table must reflect a
real configuration. 

> making any assumptions about APIC availability on a processor.

 OK, but how does it handle the 82489DX?  There are valid configurations
using this kind of APIC, including Pentium P54C ones...

> And yes some boards crash otherwise.

 Hmm, the only solution I can see is to check the APIC version in the
MP-table and only if an integrated version is reported then check
capabilities.  But can we trust the version reported given that amount of
brokenness out there? 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
