Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262997AbTCSNmR>; Wed, 19 Mar 2003 08:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263006AbTCSNmR>; Wed, 19 Mar 2003 08:42:17 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:29576 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S262997AbTCSNmQ>; Wed, 19 Mar 2003 08:42:16 -0500
Date: Wed, 19 Mar 2003 13:53:09 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Juha Poutiainen <pode@iki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: L2 cache detection in Celeron 2GHz (P4 based)
Message-ID: <20030319135301.GB28770@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Juha Poutiainen <pode@iki.fi>, linux-kernel@vger.kernel.org
References: <20030319064743.GA1683@a28a>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030319064743.GA1683@a28a>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 at 08:47:43AM +0200, Juha Poutiainen wrote:

 > x86info shows that there is something with descriptor 0x3b, and 0x3c 
 > seems to be 256K L2 cache. So I guess it is as simple as adding a line:
 > 
 >           { 0x3B, LVL_2,      128 },
 > 
 > in arch/i386/kernel/setup.c  after line 2204 (2.4.20) and
 > in arch/i386/kernel/cpu/intel.c  after line 102 (2.5.65)

Yep, that's exactly the right fix.
x86info cvs updated, and 2.5 patch queued for Linus.
I'll do a 2.4 patch later if you haven't already done so.

 > I've tried both, they seems to report it fine, but I can't be sure if 
 > that really is correct id of that cache. Celeron at issue has 128K L2 
 > cache.

Intel document 24161822.pdf confirms it.

		Dave

