Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130235AbQLGQmo>; Thu, 7 Dec 2000 11:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130876AbQLGQme>; Thu, 7 Dec 2000 11:42:34 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:13027 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S130235AbQLGQm0>; Thu, 7 Dec 2000 11:42:26 -0500
Date: Thu, 7 Dec 2000 17:07:07 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Microsecond accuracy
In-Reply-To: <90oak3$326$1@cesium.transmeta.com>
Message-ID: <Pine.GSO.3.96.1001207165626.21086F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Dec 2000, H. Peter Anvin wrote:

> Unfortunately the most important instance of the in-kernel flag -- the
> global one in the somewhat misnamed boot_cpu_data.x86_features --
> isn't actually readable in the /proc/cpuinfo file.  It is perfectly
> possible (e.g. the "notsc" option) for ALL the CPUs to report this
> capability, but the global capability to still be off.

 Hmm, I recall I implemented and explicitly verified switching the
/proc/cpuinfo "tsc" flag (as well as the userland access to the TSC) off
when I wrote the code to handle the "notsc" option.  Has it changed since
then?  I recall you modified the code a bit -- I looked at the changes
then but I was pretty confident the semantics was preserved.

 There is no possibility to have TSC and non-TSC chips mixed in a single
SMP system (due to existing hardware, even though it's possible in
theory), so there is no problem with such an assymetry.  Either all chips
have the "tsc" flag in /proc/cpuinfo on or off.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
