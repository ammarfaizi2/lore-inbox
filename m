Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946433AbWJSUL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946433AbWJSUL7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 16:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946434AbWJSUL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 16:11:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35475 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1946432AbWJSUL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 16:11:57 -0400
Date: Thu, 19 Oct 2006 16:11:16 -0400
From: Dave Jones <davej@redhat.com>
To: Len Brown <lenb@kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
Subject: Re: SMP broken on pre-ACPI machine.
Message-ID: <20061019201116.GG26530@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Len Brown <lenb@kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux-acpi@vger.kernel.org
References: <20061018222433.GA4770@redhat.com> <200610190133.40581.len.brown@intel.com> <20061019191644.GE26530@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061019191644.GE26530@redhat.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 03:16:44PM -0400, Dave Jones wrote:

 > Why smp_found_config isn't set in that guys configuration is a mystery to me,
 > as his MPS tables look sane..
 > 
 > MP Table:
 > #	APIC ID	Version	State		Family	Model	Step	Flags
 > #	 0	 0x10	 BSP, usable	 6	 2	 1	 0x0381
 > #	 0	 0x10	 AP, usable	 6	 1	 7	 0xfbff
 > 
 > Hmm, wait, he has unpaired CPUs. I wonder if that's the reason.
 > I know *some* combinations of PPro's are valid to be paired, but I'll
 > need to dig out the old docs to be sure.
 
Ok, after reading http://www.intel.com/design/archives/processors/pro/docs/242689.htm
I'm more puzzled than ever.  There never was a model 2 Pentium Pro.
Either this BIOS is on crack and putting nonsense in its MPS tables,
or this is a hardware flaw of some sort.

	Dave

-- 
http://www.codemonkey.org.uk
