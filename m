Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264647AbTFEMGq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 08:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264650AbTFEMGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 08:06:46 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:36304 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S264647AbTFEMFV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 08:05:21 -0400
Date: Thu, 5 Jun 2003 14:19:18 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: "Brian J. Murrell" <brian@interlinx.bc.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: local apic timer ints not working with vmware: nolocalapic
In-Reply-To: <Pine.LNX.4.50.0306030827550.14455-100000@montezuma.mastecende.com>
Message-ID: <Pine.GSO.3.96.1030605141622.5828F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jun 2003, Zwane Mwaikambo wrote:

> > On Sat, 31 May 2003, Zwane Mwaikambo wrote:
> >  How about clearing cpu_has_apic and smp_found_config instead?  As I
> > understand the problem, the local APIC is useless so the kernel shouldn't
> > pretend it's present.  And the MP-table is useless without a local APIC. 
> 
> I agree, but there are already the appropriate checks for wether there is 
> an APIC enabled that should suffice.

 You may have a valid SMP table and discrete local APICs (i82489DX) which
are not reported in CPU capability bits.  The "nolocalapic" option should
handle them, too.  Otherwise it would be a surprising inconsistency. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

