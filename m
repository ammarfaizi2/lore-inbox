Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751733AbVLAXW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbVLAXW1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 18:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbVLAXW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 18:22:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7148 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751732AbVLAXW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 18:22:26 -0500
Date: Thu, 1 Dec 2005 15:22:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Richard Knutsson <ricknu-0@student.ltu.se>
Cc: linux-kernel@vger.kernel.org, ricknu-0@student.ltu.se
Subject: Re: [PATCH 2.6.15-rc3(-mm1) 3/3] pci.h:
Message-Id: <20051201152210.517b936d.akpm@osdl.org>
In-Reply-To: <20051201130438.28376.78967.sendpatchset@thinktank.campus.ltu.se>
References: <20051201130338.28376.65935.sendpatchset@thinktank.campus.ltu.se>
	<20051201130438.28376.78967.sendpatchset@thinktank.campus.ltu.se>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Knutsson <ricknu-0@student.ltu.se> wrote:
>
>  +#if 0
>   /*
>    * pci_module_init is obsolete, this stays here till we fix up all usages of it
>    * in the tree.
>    */
>   #define pci_module_init	pci_register_driver
>  +#endif

This one's a bit optimistic.  We need to wait until Linus's patch is fully
converted, than wait a bit.

You might investigate turning this into an inline function, then mark it
__deprecated and generate a Documentation/feature-removal-schedule.txt
record for it.
