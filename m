Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132787AbRAQL3m>; Wed, 17 Jan 2001 06:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133112AbRAQL3c>; Wed, 17 Jan 2001 06:29:32 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:54753 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S132787AbRAQL3U>; Wed, 17 Jan 2001 06:29:20 -0500
Date: Wed, 17 Jan 2001 12:22:25 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dominik Kubla <dominik.kubla@uni-mainz.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: APIC errors
In-Reply-To: <20010117091432.B29123@uni-mainz.de>
Message-ID: <Pine.GSO.3.96.1010117120527.22695A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2001, Dominik Kubla wrote:

> Just switched to 2.4.0-ac9 (+crypto patches) on our Dual-Pentium MMX
> webserver yesterday.  Works fine so far, except i keep seeing those
> APIC erros (about 14 in 12 hrs) indicating receive, send and CS errors.
> 
> Should i be concerned?

 At this volume I would treat this as a warning but not a critical issue. 
Inter-APIC messages get retransmitted in case of an error, but the
checksum circuit is not sophisticated -- a double-bit error might pass
unnoticed leading to a system unstability under certain conditions.  At
such a low volume of errors double-bit ones are not likely to happen. 

 It's the first report of APIC errors on a P5 system I have seen, so it's
probably not a result of a bad motherboard design.  I'd recommend to check
if the system doesn't get overheated.  You may also be unlucky to have a
faulty board. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
