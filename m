Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423844AbWKHWrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423844AbWKHWrb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423845AbWKHWra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:47:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27303 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423844AbWKHWra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:47:30 -0500
Date: Wed, 8 Nov 2006 14:44:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rdreier@cisco.com, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH] IB/ipath - program intconfig register using new HT irq
 hook
Message-Id: <20061108144402.0b6a7b23.akpm@osdl.org>
In-Reply-To: <545156d49f883c43af70.1163024486@localhost.localdomain>
References: <545156d49f883c43af70.1163024486@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Nov 2006 14:21:26 -0700
"Bryan O'Sullivan" <bos@pathscale.com> wrote:

> Eric's changes to the htirq infrastructure require corresponding
> modifications to the ipath HT driver code so that interrupts are still
> delivered properly.
> 
> Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Roland Dreier <rdreier@cisco.com>
> 
> diff -r 69779e2890e3 -r 545156d49f88 drivers/infiniband/hw/ipath/ipath_driver.c
> --- a/drivers/infiniband/hw/ipath/ipath_driver.c	Wed Nov 08 14:17:04 2006 -0800
> +++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Wed Nov 08 14:19:27 2006 -0800

so...  Is this:

htirq-refactor-so-we-only-have-one-function-that-writes-to-the-chip.patch
htirq-allow-buggy-drivers-of-buggy-hardware-to-write-the-registers.patch
htirq-allow-buggy-drivers-of-buggy-hardware-to-write-the-registers-update.patch
ib-ipath-program-intconfig-register-using-new-ht-irq-hook.patch

considered 2.6.19 material?
