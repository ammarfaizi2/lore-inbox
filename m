Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131174AbRAXUKm>; Wed, 24 Jan 2001 15:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131082AbRAXUKe>; Wed, 24 Jan 2001 15:10:34 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:15312 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S131212AbRAXUKX>; Wed, 24 Jan 2001 15:10:23 -0500
Date: Wed, 24 Jan 2001 13:35:03 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andrew Morton <andrewm@uow.edu.au>
cc: John Roll <john@cfa.harvard.edu>, linux-kernel@vger.kernel.org
Subject: Re: Network hang with 2.4.1-pre9 and 3c59x
In-Reply-To: <3A6E247A.C6A2FD17@uow.edu.au>
Message-ID: <Pine.GSO.3.96.1010124132925.8454B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jan 2001, Andrew Morton wrote:

> This is due to a lost APIC interrupt acknowledgement.  A workaround
> is to boot with the `noapic' LILO option.
> 
> This long-standing and very nasty problem was discussed extensively
> a week or two ago.  Suspicions were cast at the disable_irq() function
> but I'm not sure anything 100% conclusive was arrived at.

 Not sure if that is 100% conclusive but I decided to develop an APIC
lockup recovery procedure.  Fortunately chips provide us enough
information we may deal with the problem with moderate pain.

> I guess I'll have to find a way to make disable_irq() go away,
> see if that helps.

 Please don't.  This would be hiding problems under a carpet.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
