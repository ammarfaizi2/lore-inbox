Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265955AbUA1Nix (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 08:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265961AbUA1Nix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 08:38:53 -0500
Received: from linux.us.dell.com ([143.166.224.162]:33970 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S265955AbUA1Nh4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 08:37:56 -0500
Date: Wed, 28 Jan 2004 07:37:37 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Andrew Morton <akpm@osdl.org>,
       Alessandro Suardi <alessandro.suardi@oracle.com>,
       linux-kernel@vger.kernel.org, linux-acpi@intel.com
Subject: Re: 2.6.2-rc2-bk1 oopses on boot (ACPI patch)
Message-ID: <20040128073737.A29748@lists.us.dell.com>
References: <40171B5B.4020601@oracle.com> <20040127184228.3a0b8a86.akpm@osdl.org> <200401272337.55676.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200401272337.55676.dtor_core@ameritech.net>; from dtor_core@ameritech.net on Tue, Jan 27, 2004 at 11:37:55PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 11:37:55PM -0500, Dmitry Torokhov wrote:
> > Divide by zero.  Looks like ACPI is now passing bad values into the
> > frequency change notifier.
> 
> It is a common problem with Dell's DSDT implementation which does not
> follow ACPI spec and it's been going on for ages. From the original
> report:
> 
> cpufreq: CPU0 - ACPI performance management activated
>  cpufreq: *P0: 1Mhz, 0 mW, 0 uS
>  cpufreq: P1: 0Mhz, 0 mW, 0 uS
>  divide error: 0000 [#1]
> 
> As you can see all data is bogus... Patching DSDT cures it for sure,
> sometimes CONFIG_ACPI_RELAXED_AML helps as well.

Please send me your DSDT and output of dmidecode, and ideally what a
proper DSDT should show in this case (I'm not familiar enough with
what all the various ACPI tables should contain), and I'll take it up
with the BIOS programmers for that platform.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
