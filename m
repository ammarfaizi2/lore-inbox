Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLGTVv>; Thu, 7 Dec 2000 14:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129314AbQLGTVl>; Thu, 7 Dec 2000 14:21:41 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:37349 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129267AbQLGTVg>; Thu, 7 Dec 2000 14:21:36 -0500
Date: Thu, 7 Dec 2000 19:47:47 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andi Kleen <ak@suse.de>
cc: richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Why is double_fault serviced by a trap gate?
In-Reply-To: <20001207192958.A32075@gruyere.muc.suse.de>
Message-ID: <Pine.GSO.3.96.1001207193917.21086L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Andi Kleen wrote:

> Interesting. One of my ports references for PCs lists
> 
> 0044    r/w     PIT  counter 3 (PS/2, EISA)
>                 used as fail-safe timer. generates an NMI on time out.
>                 for user generated NMI see at 0462.

 Oh no, we don't use that.  Even though we could, it's rare -- it exists
for EISA systems only and then mostly older ones (i.e. non-PCI ones).

 In fact the only chipset that provides these additional NMI sources I
have docs for is the i82350 one. 

> I don't know if modern PCs still provide this counter, but if yes it could
> be used for a slow NMI watchdog that only runs every 30s or so. 

 An ability to choose a NMI frequency, especially such a low one, would be
desirable but it is really inexistent for most IA32 systems. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
