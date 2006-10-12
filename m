Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422781AbWJLHLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422781AbWJLHLo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 03:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422780AbWJLHLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 03:11:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20416 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422778AbWJLHLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 03:11:43 -0400
Date: Thu, 12 Oct 2006 00:11:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Judith Lebzelter" <judith@osdl.org>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IA64 export symbols empty_zero_page, ia64_ssc
Message-Id: <20061012001139.1fea6ecf.akpm@osdl.org>
In-Reply-To: <617E1C2C70743745A92448908E030B2AA634B8@scsmsx411.amr.corp.intel.com>
References: <617E1C2C70743745A92448908E030B2AA634B8@scsmsx411.amr.corp.intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006 15:52:28 -0700
"Luck, Tony" <tony.luck@intel.com> wrote:

> Judith,
> 
> +++ linux/arch/ia64/kernel/ia64_ksyms.c	2006-10-09 10:15:18.000000000 -0700
> 
> These exports are only needed for the HP simulator ... it seems
> probable that the more likely fix is change Kconfig to prevent simscsi
> from being built as a module.  I assume that any remaining SKI users
> build this into the kernel ... arch/ia64/configs/sim_defconfig sets
> CONFIG_HP_SIMSCSI=y for example.
> 

The problem is that ia64 allmodconfig now bombs out, since depmod treats
this as a hard error.

IOW, please make allmodconfig work ;)
