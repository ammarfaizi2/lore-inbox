Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275216AbTHMOcn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 10:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275218AbTHMOcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 10:32:42 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:54447 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S275216AbTHMOcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 10:32:41 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16186.19463.54075.109122@gargle.gargle.HOWL>
Date: Wed, 13 Aug 2003 16:32:39 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ruben Puettmann <ruben@puettmann.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22 APM problems with IBM Thinkpad's
In-Reply-To: <1060783884.8008.64.camel@dhcp23.swansea.linux.org.uk>
References: <20030813123119.GA25111@puettmann.net>
	<16186.14686.455795.927909@gargle.gargle.HOWL>
	<1060783884.8008.64.camel@dhcp23.swansea.linux.org.uk>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
 > On Mer, 2003-08-13 at 14:13, Mikael Pettersson wrote:
 > > With APIC support enabled (SMP or UP_APIC), APM must be constrained:
 > > DISPLAY_BLANK off
 > > CPU_IDLE off
 > > built-in driver, not module
 > 
 > This isnt sufficient because some of the SMM traps off the FN-key 
 > sequences also crash thinkpads if APIC is enabled. Basically *dont use
 > local apic* except on SMP.

For those Thinkpads a DMI blacklist entry should suffice.
(Just like it solved the Inspiron problems.)

2.6-mm has the "lapic" and "nolapic" options I added so that
P4s no longer are autoenabled, needed for broken ACPI BIOSen.
Perhaps we should require the "lapic" option also for all P6s?

(Strangely, K7 machines seem to have fewer local APIC BIOS issues
than either P6 or P4 machines.)
