Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbTFJWDF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 18:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbTFJWDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 18:03:05 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:62345 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262151AbTFJWC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 18:02:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16102.22713.50999.54138@gargle.gargle.HOWL>
Date: Wed, 11 Jun 2003 00:16:25 +0200
From: mikpe@csd.uu.se
To: Steven Cole <elenstev@mesatop.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Samuel Flory <sflory@rackable.com>,
       John Appleby <john@dnsworld.co.uk>, xyko_ig@ig.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Wrong number of cpus detected/reported
In-Reply-To: <1055281927.2269.47.camel@spc9.esa.lanl.gov>
References: <434747C01D5AC443809D5FC540501131569E@bobcat.unickz.com>
	<3EE64161.5010102@rackable.com>
	<1055279041.2270.42.camel@spc9.esa.lanl.gov>
	<1055280955.32661.35.camel@dhcp22.swansea.linux.org.uk>
	<1055281927.2269.47.camel@spc9.esa.lanl.gov>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole writes:
 > On Tue, 2003-06-10 at 15:35, Alan Cox wrote:
 > > > wp		: yes
 > > > flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
 > > > bogomips	: 2798.38
 > > > 
 > > > See that ht flag near the end?
 > > 
 > > The ht flag means the ht facilities (mtrr etc) are present, doesnt mean
 > > HT necessarily is
 > 
 > Is there a reliable method, apart from knowing 'a priori' the mapping
 > from CPU models and stepping to hyperthreading capability?

Yes. Execute cpuid with eax=1 on each CPU. ebx describes among other things
the number of threads and which thread you're on. If you ever find yourself
on a non-zero thread, you have HT.
