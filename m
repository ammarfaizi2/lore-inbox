Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264856AbSKEN36>; Tue, 5 Nov 2002 08:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264857AbSKEN36>; Tue, 5 Nov 2002 08:29:58 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:16048 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S264856AbSKEN35>;
	Tue, 5 Nov 2002 08:29:57 -0500
Date: Tue, 5 Nov 2002 13:35:00 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, venkatesh.pallipadi@intel.com
Subject: Re: [PATCH][2.5-AC] Start from bank 0 for P4 MCE init (resend)
Message-ID: <20021105133500.GA18426@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Zwane Mwaikambo <zwane@holomorphy.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, venkatesh.pallipadi@intel.com
References: <Pine.LNX.4.44.0211042107590.27141-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211042107590.27141-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 11:59:38PM -0500, Zwane Mwaikambo wrote:
 > Index: linux-2.5.44-ac5/arch/i386/kernel/cpu/mcheck/p4.c
 > ===================================================================
 > RCS file: /build/cvsroot/linux-2.5.44-ac5/arch/i386/kernel/cpu/mcheck/p4.c,v
 > retrieving revision 1.1.1.1
 > diff -u -r1.1.1.1 p4.c
 > --- linux-2.5.44-ac5/arch/i386/kernel/cpu/mcheck/p4.c	3 Nov 2002 07:20:04 -0000	1.1.1.1
 > +++ linux-2.5.44-ac5/arch/i386/kernel/cpu/mcheck/p4.c	3 Nov 2002 16:47:14 -0000
 > @@ -220,7 +220,7 @@
 >  		wrmsr(MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
 >  	banks = l&0xff;
 >  
 > -	for(i=1; i<banks; i++)
 > +	for(i=0; i<banks; i++)
 >  		wrmsr(MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);

Ack. Already in my mcheck bits due to go to Linus today.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
