Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264966AbTFCLd1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 07:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264967AbTFCLd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 07:33:27 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:54728 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S264966AbTFCLd1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 07:33:27 -0400
Date: Tue, 3 Jun 2003 13:47:33 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: "Brian J. Murrell" <brian@interlinx.bc.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: local apic timer ints not working with vmware: nolocalapic
In-Reply-To: <Pine.LNX.4.50.0305310246250.31414-100000@montezuma.mastecende.com>
Message-ID: <Pine.GSO.3.96.1030603133821.29576A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 May 2003, Zwane Mwaikambo wrote:

> > Is it really valid to go and try to calibrate the APIC timer if it was
> > disabled by the user, or even DMI?
> 
> bah, the early boot hacks are just ugly, we do detect_init_APIC early in 
> traps code and then just blindly go frobbing the APIC anyway.

 How about clearing cpu_has_apic and smp_found_config instead?  As I
understand the problem, the local APIC is useless so the kernel shouldn't
pretend it's present.  And the MP-table is useless without a local APIC. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

