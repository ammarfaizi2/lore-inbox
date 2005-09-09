Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbVIIPxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbVIIPxD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 11:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbVIIPxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 11:53:03 -0400
Received: from fsmlabs.com ([168.103.115.128]:60089 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S932145AbVIIPxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 11:53:01 -0400
Date: Fri, 9 Sep 2005 08:59:26 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Jan Beulich <JBeulich@novell.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix i386 interrupt re-enabling in die() (attempt 2)
In-Reply-To: <432175CB02000078000248D0@emea1-mh.id2.novell.com>
Message-ID: <Pine.LNX.4.61.0509090855080.14063@montezuma.fsmlabs.com>
References: <4320718A0200007800024476@emea1-mh.id2.novell.com>
 <Pine.LNX.4.63.0509081036110.8052@r3000.fsmlabs.com>
 <432175CB02000078000248D0@emea1-mh.id2.novell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jan,

On Fri, 9 Sep 2005, Jan Beulich wrote:

> -		spin_lock_irq(&die.lock);
> +		spin_lock_irqsave(&die.lock, flags);
>  		die.lock_owner = smp_processor_id();
>  		die.lock_owner_depth = 0;
>  		bust_spinlocks(1);
>  	}
> +	else
> +		local_save_flags(flags);

Just one tiny nit, that else should be on the same line as the curly 
brace.

Thanks
