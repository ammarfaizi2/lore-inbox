Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUEMPeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUEMPeP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 11:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbUEMPeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 11:34:15 -0400
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:6666
	"EHLO muru.com") by vger.kernel.org with ESMTP id S264265AbUEMPd6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 11:33:58 -0400
Date: Thu, 13 May 2004 08:34:01 -0700
From: Tony Lindgren <tony@atomide.com>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org, pavel@ucw.cz
Cc: cpufreq@www.linux.org.uk
Subject: Re: [tony@atomide.com: [PATCH] Powernow-k8 buggy BIOS override for 2.6.6]
Message-ID: <20040513153401.GB8480@atomide.com>
References: <20040513001628.GA9388@atomide.com> <20040513140501.GG16687@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040513140501.GG16687@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Jones <davej@redhat.com> [040513 07:06]:
> On Wed, May 12, 2004 at 05:16:28PM -0700, Tony Lindgren wrote:
> 
>  > Following is the updated patch to make the powernow-k8 driver work on 
>  > machines with buggy BIOS, such as emachines m6805.
>  > 
>  > The patch overrides the PST table only if check_pst_table() fails.
>  > 
>  > The minimum value for the override is 800MHz, which is the lowest value 
>  > on all x86_64 systems AFAIK. The max value is the current running value.
>  > 
>  > This patch should be safe to apply, even if Pavel's ACPI table check is
>  > added to the driver. Or does anybody see a problem with it?
> 
> Does the ACPI fallback not do the right thing ?

Does not work for me. But looks like that's because I had to turn off 
ACPI processor module since 2.6.6 since it would hang my system. It could 
also be that the hang is caused by the powernow-k8. I will check that.

> I don't really see the point of limping along with a 2-state PST
> if we can derive the proper info from the ACPI table.

Sure if the ACPI table check works properly. But even with 2-state PST,
being able to change from 1800MHz to 800MHz on battery increases the 
battery life quite a bit. And it does not necessarily require ACPI :)

Regards,

Tony
