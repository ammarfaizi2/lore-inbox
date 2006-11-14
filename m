Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755432AbWKNGb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755432AbWKNGb4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 01:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755425AbWKNGb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 01:31:56 -0500
Received: from hera.kernel.org ([140.211.167.34]:65439 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1755431AbWKNGbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 01:31:55 -0500
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required) [2.6.18-rc4-mm1]
Date: Tue, 14 Nov 2006 01:34:20 -0500
User-Agent: KMail/1.8.2
Cc: Len Brown <lenb@kernel.org>, Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       venkatesh.pallipadi@intel.com
References: <20061101140729.GA30005@rhlx01.hs-esslingen.de> <200611070141.16593.len.brown@intel.com> <20061107080733.GB9910@elte.hu>
In-Reply-To: <20061107080733.GB9910@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611140134.21054.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 November 2006 03:07, Ingo Molnar wrote:
> > So given that C3 on every known system that has shipped to date breaks 
> > the LAPIC timer (and apparently this applies to C2 on these AMD 
> > boxes), dynticks needs a solid story for co-existing with C3.
> 
> check out 2.6.19-rc4-mm2: it detects this breakage and works it around 
> by using the PIT as a clock-events source. That did the trick on my 
> laptop which has this problem too. I agree with you that degrading the 
> powersaving mode is not an option.
> 
> we've got a question about HPET: it seems all recent hardware has it, 
> but the BIOS rarely mentions it, so the Linux driver does not enable 
> HPET. Is there any chance to enable HPET (in the chipset?) - this would 
> probably be a higher-quality clock-events source than the PIT.

If Windows enumerates and uses the HPET on a box, then Linux
should be able to use the HPET on that box too.

I belive that Venki has looked at some of the HPET enumeration issues,
and maybe he has some suggestions.  Is there an example system
on-hand where we know Windows works and Linux does not?

-Len
