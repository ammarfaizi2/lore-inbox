Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266311AbUG0Qjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266311AbUG0Qjp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 12:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266376AbUG0Qjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 12:39:44 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:8393 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266311AbUG0QjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 12:39:09 -0400
Subject: Re: [Lhms-devel] Re: [PATCH] memory hotplug for ia64 (linux-2.6.7)
	[0/2]
From: Dave Hansen <haveblue@us.ibm.com>
To: Fumitake ABE <fabe@us.fujitsu.com>
Cc: lhms <lhms-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41068115.5020202@us.fujitsu.com>
References: <20040720181135.12B6.TERASAWA@pst.fujitsu.com>
	 <40FF0BDD.9050500@us.fujitsu.com>  <41068115.5020202@us.fujitsu.com>
Content-Type: text/plain
Message-Id: <1090946301.9337.588.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 27 Jul 2004 09:38:22 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-27 at 09:21, Fumitake ABE wrote:
> +#ifndef CONFIG_MEMHOTPLUG
>   static struct early_node_data mem_data[NR_NODES] __initdata;
> +#else
> +static struct early_node_data mem_data[NR_NODES];
> +#endif

Instead of having a bunch of #ifdefs, it's best to just use __devinit
and __devinitdata.  It will switch on CONFIG_HOTPLUG, but we've used it
in a bunch of places for hotplug CPU and everyone appears to like it.  

-- Dave

