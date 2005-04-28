Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262066AbVD1Hoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbVD1Hoy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 03:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVD1Hom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 03:44:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:12220 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262066AbVD1Hlj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 03:41:39 -0400
Date: Thu, 28 Apr 2005 00:41:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Li Shaohua <shaohua.li@intel.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       len.brown@intel.com, pavel@suse.cz, zwane@linuxpower.ca
Subject: Re: [PATCH 6/6]suspend/resume SMP support
Message-Id: <20050428004108.3c670bf2.akpm@osdl.org>
In-Reply-To: <1114673297.26367.3.camel@sli10-desk.sh.intel.com>
References: <1113283867.27646.434.camel@sli10-desk.sh.intel.com>
	<20050428002254.461fcf32.akpm@osdl.org>
	<1114673297.26367.3.camel@sli10-desk.sh.intel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Li Shaohua <shaohua.li@intel.com> wrote:
>
> On Thu, 2005-04-28 at 15:22, Andrew Morton wrote:
> > -#ifdef CONFIG_HOTPLUG_CPU
> > +#if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_SOFTWARE_SUSPEND)
> ACPI_SLEEP also requires it. So it will be
> #if defined(CONFIG_HOTPLUG_CPU) && (defined(CONFIG_SOFTWARE_SUSPEND) || defined(CONFIG_ACPI_SLEEP))
> 

But does setting CONFIG_ACPI_SLEEP cause kernel/power/smp.o to be actually
compiled and linked?  I don't think so?

Anyway, please send a tested fix.
