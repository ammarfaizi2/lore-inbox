Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268335AbUJDRXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268335AbUJDRXJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 13:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268336AbUJDRXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 13:23:09 -0400
Received: from fmr03.intel.com ([143.183.121.5]:11738 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S268335AbUJDRXA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 13:23:00 -0400
Date: Mon, 4 Oct 2004 10:22:20 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Josef 'Jeff' Sipek" <jeffpc@optonline.net>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, trivial@rustcorp.com.au, rusty@rustcorp.com.au
Subject: Re: [PATCH 2.6][resend] Add DEVPATH env variable to hotplug helper call
Message-ID: <20041004102220.A3304@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20041003100857.GB5804@optonline.net> <20041003162012.79296b37.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041003162012.79296b37.akpm@osdl.org>; from akpm@osdl.org on Sun, Oct 03, 2004 at 04:20:12PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 03, 2004 at 04:20:12PM -0700, Andrew Morton wrote:
> Does CPU hotplug behave correctly wrt /sys/devices/system/cpu?  Given that
> register_cpu() is still marked __init, I assume not.

Currently what we have in the kernel is logical cpu hotplug, i.e once the
cpu is registered via register_cpu() that cpu can only go offline and still
the entry for that cpu will be present in the /sys/devices/system/cpu/cpuX/online.

So __init register_cpu() is fine untill we support unregister_cpu()
which is required for physical cpu hotplug case.

I have submitted ACPI based physical cpu hotplug patches and waiting to here from
ACPI mainitainer Len Brown, there I have taken care to support unregister_cpu()
and register_cpu() is marked as __devinit in those patches.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
