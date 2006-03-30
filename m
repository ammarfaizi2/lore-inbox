Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbWC3FJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbWC3FJb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 00:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWC3FJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 00:09:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62420 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751007AbWC3FJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 00:09:31 -0500
Date: Wed, 29 Mar 2006 21:09:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pete Clements <clem@clem.clem-digital.net>
Cc: clem@clem.clem-digital.net, klassert@mathematik.tu-chemnitz.de,
       linux-kernel@vger.kernel.org
Subject: Re: Correction: 2.6.16-git12 killed networking -- 3c900 card
Message-Id: <20060329210904.3e1391bb.akpm@osdl.org>
In-Reply-To: <200603300451.k2U4pcaK001781@clem.clem-digital.net>
References: <20060329171030.3d475bcb.akpm@osdl.org>
	<200603300451.k2U4pcaK001781@clem.clem-digital.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Clements <clem@clem.clem-digital.net> wrote:
>
> Quoting Andrew Morton
>   > 
>   > Oh damn.  So you're sure that 3c59x.global_enable_wol=0 actually makes the
>   > driver behave better?
>   > 
> Ok, new results.
> Built a new virgin 2.6.16.
> 1) able to stimulate a tx time out message
> 2) rebooted with 3c59x.global_enable_wol=0 on command line,
>    able to stimulate a tx time out message
> 
> Applied the collision statistics fix fix. Changed the extraversion
> in the top Makefile to preserve my baseline, also make does more
> work than previous. 
> 1) Booted and unable to stimulate a tx time out message
> 
> Rebooted to virgin 2.6.16
> 1) able to stimulate a tx time out message
> 2) rebooted with 3c59x.global_enable_wol=0 on command line,
>    able to stimulate a tx time out message
> 
> Rebooted to the patched driver kernel (collision statistics fix fix)
> 1) unable to stimulate a tx time out message.
> 
> Rebooted to virgin 2.6.16
> 1) able to stimulate a tx time out message
> 
> Appears that earlier results were tainted.
> 

OK, thanks.  So it looks like 3c59x-collision-statistics-fix-fix.patch is
the only patch which we need to return your machine to working condition?

