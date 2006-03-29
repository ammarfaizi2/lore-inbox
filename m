Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWC2UMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWC2UMK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 15:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWC2UMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 15:12:09 -0500
Received: from ms-smtp-01.tampabay.rr.com ([65.32.5.131]:11246 "EHLO
	ms-smtp-01.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1751141AbWC2UMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 15:12:08 -0500
Date: Wed, 29 Mar 2006 15:12:06 -0500
From: JimD <Jim@keeliegirl.dyndns.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AMD64 overclock issue with 2.6.16 but not with 2.6.15
Message-ID: <20060329151206.2bc7bd04@keelie.localdomain>
In-Reply-To: <200603292054.09385.s0348365@sms.ed.ac.uk>
References: <20060329143523.3bbb4df7@keelie.localdomain>
	<200603292054.09385.s0348365@sms.ed.ac.uk>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2006 20:54:09 +0100
Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> At a guess, it sounds like you're trying to use cpufreq on an
> overclocked CPU, a definitely no-no. Check your config for this
> option, remove it if desired.

mnt/sda/usr/src/linux-2.6.15-gentoo-r7
jim@keelie$ grep -i cpufreq .config
# CPUFreq processor drivers
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_X86_ACPI_CPUFREQ_PROC_INTF=y


/mnt/sda/usr/src/linux-2.6.16-gentoo
jim@keelie$ grep -i cpufreq .config
# CPUFreq processor drivers
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_X86_ACPI_CPUFREQ_PROC_INTF=y

If I boot into 2.6.15 /proc/cpuinfo show the correct info and the AMD
cool-n-quite thingy is working real well.  It put the processor at 1100
MHz or instantly ramps up to 2200 MHz.  If I boot into 2.6.16, the AMD
cool-n-quite thingy works, but now the processor goes down to 1000 MHz
or 2000 MHz.

I will recompile 2.6.16 without cpufreq and see if that help.

Jim
