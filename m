Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbTICJti (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 05:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbTICJti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 05:49:38 -0400
Received: from lidskialf.net ([62.3.233.115]:8326 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S261725AbTICJth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 05:49:37 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Roger Luethi <rl@hellgate.ch>
Subject: Re: [ACPI] Where do I send APIC victims?
Date: Wed, 3 Sep 2003 11:48:03 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
References: <20030903080852.GA27649@k3.hellgate.ch> <200309031123.58713.adq_dvb@lidskialf.net> <20030903093808.GA28594@k3.hellgate.ch>
In-Reply-To: <20030903093808.GA28594@k3.hellgate.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309031148.03941.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > with these chipsets. I'm waiting on some docs from VIA to fix this issue.
>
> Which still leaves the question of why it used to work (or made the
> impression it did) with older kernels.

I think on earlier kernels there was a bug in ACPI which prevented it from 
being used for PCI IRQ routing. I know this was fixed somewhere in the 2.5.5X 
series.

When this bug was fixed, it unfortunately caused my nforce2 board to stop 
working because of other IRQ issues, which is how I got into this. Its likely 
the same thing causes older kernels to work with Via motherboards to work 
'cos ACPI isn't being used for IRQ routing.

2.4.22 has the ACPI from 2.6 backported into it, (which includes my patch for 
nforce2 boards) so it will start having the same issue with the BIOS bug in 
KT333/KT400  boards.

