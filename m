Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVCYAwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVCYAwL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 19:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVCYAvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 19:51:00 -0500
Received: from ipx10069.ipxserver.de ([80.190.240.67]:60393 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S261282AbVCYAiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 19:38:05 -0500
Date: Fri, 25 Mar 2005 01:17:30 +0100
From: Felix von Leitner <felix-linuxkernel@fefe.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Adam Belay <abelay@novell.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, cpufreq@ZenII.linux.org.uk
Subject: Re: 2.6.11: USB broken on nforce4, ipv6 still broken, centrino speedstep even more broken than in 2.6.10
Message-ID: <20050325001729.GA30397@codeblau.de>
References: <20050311202122.GA13205@fefe.de> <20050311173517.7fe95918.akpm@osdl.org> <1110599659.12485.279.camel@localhost.localdomain> <20050321163225.4af1c169.akpm@osdl.org> <1111454454.6633.5.camel@linux.site> <20050322222943.GA10442@codeblau.de> <42434E60.1060209@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42434E60.1060209@goop.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Jeremy Fitzhardinge (jeremy@goop.org):
> Unfortunately, the Dothans *REQUIRE* some degree of ACPI support; the
> speedfreq-centrino needs to extract a table from ACPI to know what are
> valid operating (voltage/frequency) points to use for the CPU.  The
> patch you're using is definitely wrong in principle, though if it works
> for you in practice then by all means use it.

I enabled these:

  CONFIG_CPU_FREQ=y
  CONFIG_CPU_FREQ_STAT=y
  CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
  CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
  CONFIG_CPU_FREQ_GOV_POWERSAVE=y
  CONFIG_CPU_FREQ_GOV_USERSPACE=y
  CONFIG_CPU_FREQ_GOV_ONDEMAND=y
  CONFIG_CPU_FREQ_TABLE=y
  CONFIG_X86_SPEEDSTEP_CENTRINO=y
  CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=y
  CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y

It should have worked, shouldn't it?

Well, it did not.  You can look at the kernel messages at
http://dl.fefe.de/dmesg.gz if that helps.

No cpufreq, and as far as I can see, no speedstep.
The fan is running, that's all I can tell.

Felix
