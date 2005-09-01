Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbVIAPdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbVIAPdr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbVIAPdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:33:47 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:61354 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030205AbVIAPdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:33:45 -0400
Date: Thu, 1 Sep 2005 10:30:38 -0500
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Natalie.Protasevich@unisys.com
Cc: shaohua.li@intel.com, akpm@osdl.org, zwane@arm.linux.org.uk,
       hotplug_sig@lists.osdl.org, linux-kernel@vger.kernel.org,
       lhcs-devel@lists.sourceforge.net, ak@suse.de
Subject: Re: [Hotplug_sig] [patch 1/1] Hot plug CPU to support physical add of new processors (i386)
Message-ID: <20050901153038.GR23400@localhost.localdomain>
References: <20050831121311.5FC7C57D99@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050831121311.5FC7C57D99@linux.site>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Natalie.Protasevich@unisys.com wrote:

> +#ifdef CONFIG_HOTPLUG_CPU
> +	if (cpu_online(cpu)) {
> +#else
>  	if (cpu_online(cpu) || !cpu_present(cpu)) {
> +#endif
>  		ret = -EINVAL;
>  		goto out;
>  	}

Why this change?  I think the cpu_present check is needed for ppc64
since it has non-present cpus in sysfs.

