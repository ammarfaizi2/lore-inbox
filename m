Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318199AbSGWT0s>; Tue, 23 Jul 2002 15:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318202AbSGWT0s>; Tue, 23 Jul 2002 15:26:48 -0400
Received: from ns.suse.de ([213.95.15.193]:29445 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318199AbSGWT0r>;
	Tue, 23 Jul 2002 15:26:47 -0400
Date: Tue, 23 Jul 2002 21:29:57 +0200
From: Dave Jones <davej@suse.de>
To: Patrick Mochel <mochel@osdl.org>
Cc: Markus Pfeiffer <profmakx@profmakx.org>, linux-kernel@vger.kernel.org
Subject: Re: CPU detection broken in 2.5.27?
Message-ID: <20020723212957.B16446@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Patrick Mochel <mochel@osdl.org>,
	Markus Pfeiffer <profmakx@profmakx.org>, linux-kernel@vger.kernel.org
References: <20020721184151.A17463@suse.de> <Pine.LNX.4.44.0207231211380.954-100000@cherise.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0207231211380.954-100000@cherise.pdx.osdl.net>; from mochel@osdl.org on Tue, Jul 23, 2002 at 12:14:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 12:14:08PM -0700, Patrick Mochel wrote:

There are some problems here.

 > +		{ X86_VENDOR_INTEL,     6,
 > +		  { 
 > +			  [0] "Pentium Pro A-step",
 > +			  [1] "Pentium Pro", 
 > +			  [3] "Pentium II (Klamath)", 

[4] is Deschutes according to the docs I used for x86info.

 > +			  [5] "Pentium II (Deschutes)", 

What [5] is is dependant upon cache size & stepping.

stepping 0:
    0KB - Celeron (Covington)
    256KB - Mobile Pentium II (Dixon)
stepping 1-3 Pentium II (Deschutes)

 > +			  [6] "Mobile Pentium II",

cache size 128KB - Celeron (Mendocino)
Stepping 0/5 - Celeron-A
Stepping A - Mobile PII

 > +			  [8] "Pentium III (Coppermine)", 

L2 Cachesize == 128 == Celeron (Else P3)


 > +			  [10] "Pentium III (Cascades)",

6a0 is another P2 Deschutes aparently, but this seems
odd, and I should double check this sometime.

 > +			  [11] "Pentium III (Tualatin)",

Could be a celeron too. Not sure of cache size.

 > +			  [1] "Pentium 4 (Unknown)",

Model 5 = (Foster)
Unsure of other codenames.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
