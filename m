Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbTFKPuy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 11:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbTFKPuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 11:50:54 -0400
Received: from wmail.atlantic.net ([209.208.0.84]:10720 "HELO
	wmail.atlantic.net") by vger.kernel.org with SMTP id S262525AbTFKPuw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 11:50:52 -0400
Message-ID: <3EE7561C.9010202@techsource.com>
Date: Wed, 11 Jun 2003 12:17:32 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mikpe@csd.uu.se
CC: Steven Cole <elenstev@mesatop.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Samuel Flory <sflory@rackable.com>, John Appleby <john@dnsworld.co.uk>,
       xyko_ig@ig.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Wrong number of cpus detected/reported
References: <434747C01D5AC443809D5FC540501131569E@bobcat.unickz.com>	<3EE64161.5010102@rackable.com>	<1055279041.2270.42.camel@spc9.esa.lanl.gov>	<1055280955.32661.35.camel@dhcp22.swansea.linux.org.uk>	<1055281927.2269.47.camel@spc9.esa.lanl.gov> <16102.22713.50999.54138@gargle.gargle.HOWL>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



mikpe@csd.uu.se wrote:
> Steven Cole writes:
>  > On Tue, 2003-06-10 at 15:35, Alan Cox wrote:
>  > > > wp		: yes
>  > > > flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
>  > > > bogomips	: 2798.38
>  > > > 
>  > > > See that ht flag near the end?
>  > > 
>  > > The ht flag means the ht facilities (mtrr etc) are present, doesnt mean
>  > > HT necessarily is
>  > 
>  > Is there a reliable method, apart from knowing 'a priori' the mapping
>  > from CPU models and stepping to hyperthreading capability?
> 
> Yes. Execute cpuid with eax=1 on each CPU. ebx describes among other things
> the number of threads and which thread you're on. If you ever find yourself
> on a non-zero thread, you have HT.


I presume, however, that to get into a non-zero thread, you have to turn 
HT on.  That is, when the machine first powers up, there is nothing for 
the second thread to execute, so it's turned off.  (I'm assuming 
something similar for SMP boxes.)  So, the real question should be, 
before you attempt to turn on HT, how do you find out whether or you CAN 
turn on HT.


