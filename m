Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754656AbWKIDja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754656AbWKIDja (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 22:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754703AbWKIDja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 22:39:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14742 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1754656AbWKIDj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 22:39:29 -0500
Date: Wed, 8 Nov 2006 22:39:09 -0500
From: Dave Jones <davej@redhat.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Reuben Farrelly <reuben-linuxkernel@reub.net>,
       linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] cpufreq: select consistently (Re: 2.6.19-rc5-mm1)
Message-ID: <20061109033909.GA13729@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Andrew Morton <akpm@osdl.org>,
	Reuben Farrelly <reuben-linuxkernel@reub.net>,
	linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
References: <20061108015452.a2bb40d2.akpm@osdl.org> <4551BB5E.6090602@reub.net> <20061108120547.78048229.akpm@osdl.org> <20061108201539.GB32721@redhat.com> <20061108190944.6849b8d4.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061108190944.6849b8d4.randy.dunlap@oracle.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 07:09:44PM -0800, Randy Dunlap wrote:
 
 > Why does arch/i386/kernel/cpu/cpufreq/Kconfig say:
 > 
 > config X86_ACPI_CPUFREQ
 > 	tristate "ACPI Processor P-States driver"
 > 	select CPU_FREQ_TABLE
 > 	depends on ACPI_PROCESSOR
 > 
 > but arch/x86_64/kernel/cpufreq/Kconfig say:
 > 
 > config X86_ACPI_CPUFREQ
 > 	tristate "ACPI Processor P-States driver"
 > 	depends on ACPI_PROCESSOR
 > 
 > # NOTE: no "select" on the latter one.  // Randy

A better question might be why they're two separate Kconfig's.
x86-64 doesn't make its own copy of the drivers, so why are
the Kconfig's special ?

		Dave

-- 
http://www.codemonkey.org.uk
