Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264491AbTFKVUH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 17:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbTFKVTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 17:19:07 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:37001 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264540AbTFKVSt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 17:18:49 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Timothy Miller <miller@techsource.com>, mikpe@csd.uu.se
Subject: Re: Wrong number of cpus detected/reported
Date: Thu, 12 Jun 2003 07:26:27 +1000
User-Agent: KMail/1.5.2
Cc: Steven Cole <elenstev@mesatop.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Samuel Flory <sflory@rackable.com>, John Appleby <john@dnsworld.co.uk>,
       xyko_ig@ig.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <434747C01D5AC443809D5FC540501131569E@bobcat.unickz.com> <16102.22713.50999.54138@gargle.gargle.HOWL> <3EE7561C.9010202@techsource.com>
In-Reply-To: <3EE7561C.9010202@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306120726.28170.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jun 2003 02:17, Timothy Miller wrote:
> mikpe@csd.uu.se wrote:
> > Steven Cole writes:
> >  > On Tue, 2003-06-10 at 15:35, Alan Cox wrote:
> >  > > > wp		: yes
> >  > > > flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr mca cmov
> >  > > > pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm bogomips	:
> >  > > > 2798.38
> >  > > >
> >  > > > See that ht flag near the end?
> >  > >
> >  > > The ht flag means the ht facilities (mtrr etc) are present, doesnt
> >  > > mean HT necessarily is
> >  >
> >  > Is there a reliable method, apart from knowing 'a priori' the mapping
> >  > from CPU models and stepping to hyperthreading capability?
> >
> > Yes. Execute cpuid with eax=1 on each CPU. ebx describes among other
> > things the number of threads and which thread you're on. If you ever find
> > yourself on a non-zero thread, you have HT.
>
> I presume, however, that to get into a non-zero thread, you have to turn
> HT on.  That is, when the machine first powers up, there is nothing for
> the second thread to execute, so it's turned off.  (I'm assuming
> something similar for SMP boxes.)  So, the real question should be,
> before you attempt to turn on HT, how do you find out whether or you CAN
> turn on HT.
>
http://sourceforge.net/projects/cpucounter/

Con

