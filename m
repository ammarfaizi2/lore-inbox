Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbVI2Nzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbVI2Nzt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 09:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbVI2Nzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 09:55:49 -0400
Received: from tayrelbas04.tay.hp.com ([161.114.80.247]:13786 "EHLO
	tayrelbas04.tay.hp.com") by vger.kernel.org with ESMTP
	id S932156AbVI2Nzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 09:55:48 -0400
Date: Wed, 28 Sep 2005 18:57:27 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: perfctr-devel@lists.sourceforge.net
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Perfctr-devel] 2.6.14-rc2-mm1 new perfmon2 kernel patch available
Message-ID: <20050929015727.GB5211@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <44BDAFB888F59F408FAE3CC35AB4704102225AA9@orsmsx409> <20050928040218.GB3170@frankl.hpl.hp.com> <20050928103331.GB3808@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050928103331.GB3808@frankl.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

An updated version of the kernel patch I released yesterday
is available. It fixes the following problems:
	- compilation errors on Fedora Core 4 with gcc-4.x (reported by John Reiser)
	- range restriction not working on Itanium processors.
	- time-based event set switching not working on X86-64

You can grab the new release at:
	http://www.sf.net/projects/perfmon2

as kernel-patch: 2.6.14-rc2-mm1-050929

On Wed, Sep 28, 2005 at 03:33:31AM -0700, Stephane Eranian wrote:
> Hello everyone,
> 
> I am pleased to announce that I have released an  updated version
> of new-perfmon2 code base. This patch is against 2.6.14-rc2-mm1.
> 
> This new releases includes:
> 	- several bug fixes
> 	- many performance improvements (a PMD read on Itanium2 is down to 645 cycles).
> 	- a lot of code simplifications
> 	- support for P4/Xeon 32-bit (e.g., family 15 model 2).
> 	  includes support for HyperThreading(HT).
> 	- a P4/Xeon 32-bit sampling format for Precise Event Based sampling (PEBS)
> 
> The patch is known to work for all Itanium processors, P6/Pentium M,
> AMD X86-64, P4/Xeon 32-bit. I do not have a lot of user level support for P4 so
> testing was limited. Hopefully some people on this list may help with this.
> The EM64T is currently broken and must be updated to match the level of
> the P4/Xeon 32-bit version. The ppc64 portion has not been tested at all,
> it might not even compile.
> 
> For all PMU models, the mapping from PMC/PMD to actual PMU registers is
> accessible through /proc/perfmon_map. That is useful for people porting
> applications from other interfaces.
> 
> I encourage everybody to test this patch on their machine and report any
> problems.
> 
> You can download the new patch from our project website at:
> 
> 	http://www.sf.net/projects/perfmon2
> 
> as release: 2.6.14-rc2-mm1-050928
> 
> Enjoy,
> 
> -- 
> -Stephane
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Power Architecture Resource Center: Free content, downloads, discussions,
> and more. http://solutions.newsforge.com/ibmarch.tmpl
> _______________________________________________
> Perfctr-devel mailing list
> Perfctr-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/perfctr-devel

-- 

-Stephane
