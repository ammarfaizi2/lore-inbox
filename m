Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261646AbSLCPuf>; Tue, 3 Dec 2002 10:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261661AbSLCPuf>; Tue, 3 Dec 2002 10:50:35 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:51382 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261646AbSLCPue>;
	Tue, 3 Dec 2002 10:50:34 -0500
Date: Tue, 3 Dec 2002 15:55:29 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "Calin A. Culianu" <calin@ajvar.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SMP Pentium4 -- PAUSE Instruction
Message-ID: <20021203155529.GA1622@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Calin A. Culianu" <calin@ajvar.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33L2.0212031029580.1780-100000@rtlab.med.cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0212031029580.1780-100000@rtlab.med.cornell.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2002 at 10:42:13AM -0500, Calin A. Culianu wrote:
 > 
 > I as wondering -- according to Intel's docs they recommend that on a P4
 > processor to use the PAUSE instruction (aka rep followed by a nop) inside
 > any spin loop (such as one used in SMP spinlock code) in order to both
 > improve processor performance and reduce power consumption.
 > Is this instruction being used in spin-wait loops?  For some reason, I am
 > having a hard time figuring out whether or not it is being used.  There is
 > a rep_nop() in processor.h.. but I can't determine if that is being called
 > for spin lock lock/unlock code.

there's also rep;nop in asm-i386/spinlock.h
See spin_lock_string()

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
