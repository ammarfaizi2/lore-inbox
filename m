Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbVD1HbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbVD1HbW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 03:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVD1HbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 03:31:22 -0400
Received: from fmr18.intel.com ([134.134.136.17]:35255 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261978AbVD1HbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 03:31:19 -0400
Subject: Re: [PATCH 6/6]suspend/resume SMP support
From: Li Shaohua <shaohua.li@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
In-Reply-To: <20050428002254.461fcf32.akpm@osdl.org>
References: <1113283867.27646.434.camel@sli10-desk.sh.intel.com>
	 <20050428002254.461fcf32.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1114673297.26367.3.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 28 Apr 2005 15:28:17 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-28 at 15:22, Andrew Morton wrote:
> -#ifdef CONFIG_HOTPLUG_CPU
> +#if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_SOFTWARE_SUSPEND)
ACPI_SLEEP also requires it. So it will be
#if defined(CONFIG_HOTPLUG_CPU) && (defined(CONFIG_SOFTWARE_SUSPEND) || defined(CONFIG_ACPI_SLEEP))

Thanks,
Shaohua

