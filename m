Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264931AbTBTU16>; Thu, 20 Feb 2003 15:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266962AbTBTU15>; Thu, 20 Feb 2003 15:27:57 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:31668 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S264931AbTBTU14>;
	Thu, 20 Feb 2003 15:27:56 -0500
Date: Thu, 20 Feb 2003 20:50:17 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] replace flush_map() in arch/i386/mm/pageattr.c with flush_tlb_all()
Message-ID: <20030220205017.GA29206@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Thomas Schlichter <schlicht@uni-mannheim.de>,
	Andrew Morton <akpm@digeo.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <200302202002.h1KK2YZ00018@rumms.uni-mannheim.de> <20030220203619.GA26583@codemonkey.org.uk> <200302202131.08663.schlicht@uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302202131.08663.schlicht@uni-mannheim.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 09:30:55PM +0100, Thomas Schlichter wrote:

 > > This looks bogus. You're killing the wbinvd() in flush_kernel_map() which
 > > is needed.
 > I must admit I don't exactly know the wbinvd() command, but as the comment 
 > says:
 >   /* Could use CLFLUSH here if the CPU supports it (Hammer,P4) */
 > 
 > I thought it is not NEEDED, just a COULD...

Its hinting at a possible optimisation, not saying
that it is unneeded.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
