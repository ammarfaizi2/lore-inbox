Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbVK0N3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbVK0N3K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 08:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbVK0N3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 08:29:10 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54962 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750925AbVK0N3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 08:29:09 -0500
Date: Sun, 27 Nov 2005 13:50:33 +0100
From: Pavel Machek <pavel@suse.cz>
To: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.de>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: [PATCH] x86_64: Test patch for ATI/Nvidia timer problems
Message-ID: <20051127125032.GA1641@elf.ucw.cz>
References: <20051126142030.GA26449@wotan.suse.de> <200511271014.53217.rene@exactcode.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511271014.53217.rene@exactcode.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On Saturday 26 November 2005 15:20, Andi Kleen wrote:
> > Everybody who saw timing problems with ATI IXP based boards with x86-64
> > or some Nvidia NForce4 boards please test this patch. Please send
> > success/failure to me.
> 
> I try to give your patch a try on the ATI based MSI Megabook S270, today - 
> however even with the workaround of "noapic" I had timer drift on resuem from 
> ram if the cpu was scaled to a lower frequency when it was suspended.
> 
> The k8 cpufreq code failed to assert the current frequency and thus assumed a 
> wrong one:
> 
> Restarting tasks...<3>powernow-k8: ignoring illegal change in lo freq table-0 
> to 0x0
> powernow-k8: transition frequency failed
>  done
> 
> Also my ACPI table only has two frequency entries, 800000 and 1600000 MHz - I 
> wonder if one could rework the powernow-k8 driver to interpolate values in 
> between to get smoother adaption of the frequency?

Unfortunately, hardware can not go to anything between.
								Pavel
-- 
Thanks, Sharp!
