Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbTKYKqE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 05:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbTKYKqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 05:46:03 -0500
Received: from aun.it.uu.se ([130.238.12.36]:25984 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262308AbTKYKpK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 05:45:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16323.12977.677299.198663@alkaid.it.uu.se>
Date: Tue, 25 Nov 2003 11:45:05 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Cc: linux-kernel@vger.kernel.org
Subject: Re: hyperthreading
In-Reply-To: <yw1xptfgd9hc.fsf@kth.se>
References: <20031125094419.GB339@vega.digitel2002.hu>
	<200311251048.53046.AlberT_NOSPAM_@SuperAlberT.it>
	<20031125100526.GE339@vega.digitel2002.hu>
	<yw1xptfgd9hc.fsf@kth.se>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård writes:
 > Gábor Lénárt <lgb@lgb.hu> writes:
 > 
 > >> > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
 > >> > cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
 > >> > bogomips        : 3334.14
 > >> 
 > >> 
 > >> P4 does not support HT ... only Xeon and new generation P4-HT does.
 > >
 > > OK, but if this CPU does not support HT, then why 'ht' is shown at
 > > flags in /proc/cpuinfo? It looks like quite illogical for me then ...
 > 
 > I've been wondering about that myself.  I'm sure my P4M doesn't have
 > any hyperthreading.

Don't people read Intel docs any more?

- The HT feature flag means "might have HT, check further to make sure".
- "check further" involves checking #siblings >= 2 via CPUID.
  Old P4s typically announce HT but have #siblings < 2.
- Intel made HT enabling a hardware thing via the chipset (a pin
  sampled at reset). BIOS can disable HT but only HW can enable it.
  This is why you can't put a HT-capable P4 in a non-HT-chipset
  machine and expect it to work -- although PowerLeap seemed to
  have an adapter to "fix" that.
