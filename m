Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965150AbWADABo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965150AbWADABo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 19:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbWADABo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 19:01:44 -0500
Received: from palrel10.hp.com ([156.153.255.245]:40913 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S965146AbWADABn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 19:01:43 -0500
Date: Tue, 3 Jan 2006 16:01:41 -0800
From: Grant Grundler <iod00d@hp.com>
To: Mark Maule <maule@sgi.com>
Cc: linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Tony Luck <tony.luck@intel.com>, gregkh@suse.de
Subject: Re: [PATCH 2/3] per-platform IA64_{FIRST,LAST}_DEVICE_VECTOR definitions
Message-ID: <20060104000141.GC13841@esmail.cup.hp.com>
References: <20051222201651.2019.37913.96422@lnx-maule.americas.sgi.com> <20051222201705.2019.59377.24060@lnx-maule.americas.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222201705.2019.59377.24060@lnx-maule.americas.sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 02:15:57PM -0600, Mark Maule wrote:
> Abstract IA64_FIRST_DEVICE_VECTOR/IA64_LAST_DEVICE_VECTOR since SN platforms
> use a subset of the IA64 range.  Implement this by making the above macros
> global variables which the platform can override in it setup code.
...
> Index: msi/arch/ia64/sn/kernel/irq.c
> ===================================================================
> --- msi.orig/arch/ia64/sn/kernel/irq.c	2005-12-21 22:59:09.199823700 -0600
> +++ msi/arch/ia64/sn/kernel/irq.c	2005-12-22 14:10:01.024578027 -0600
> @@ -203,6 +203,9 @@
>  	int i;
>  	irq_desc_t *base_desc = irq_desc;
>  
> +	ia64_first_device_vector = IA64_SN2_FIRST_DEVICE_VECTOR;
> +	ia64_last_device_vector = IA64_SN2_LAST_DEVICE_VECTOR;

Shouldn't this chunk of diff go in "PATCH [2/3] altix: msi support"?
(typo: that should have been "3/3" in the original mail)

thanks,
grant
