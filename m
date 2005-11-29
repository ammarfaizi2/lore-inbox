Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751015AbVK2JdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbVK2JdF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 04:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbVK2JdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 04:33:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:22483 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750995AbVK2JdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 04:33:04 -0500
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86-64 2.6.15-rc2-git5 fails to boot with 4GB memory
References: <20051129033102.GA5706@mea-ext.zmailer.org>
From: Andi Kleen <ak@suse.de>
Date: 29 Nov 2005 07:01:12 -0700
In-Reply-To: <20051129033102.GA5706@mea-ext.zmailer.org>
Message-ID: <p73veybh7tj.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio <matti.aarnio@zmailer.org> writes:

> With 2 GB in place, the kernel boots just fine, but with
> 4 GB, it reports:

Works for me on several machines.

I even have a fix for the Asus wrong MCFG problem now that
broke the IOMMU on these boards (workaround is pci=nommconf) 

> 
>  kernel direct mapping tables upto ffff 8101 5000 000 @ 8000-f000
>  PANIC: early exception rip  ffff ffff 8016 f002 error 0 cr2 4230
>  PANIC: early exception rip  ffff ffff 8011 d1fe error 0 cr2 ffff ffff f5ff d023
> 
> and some other lines, which I didn't jot down on paper...

Can you please look up the RIP values in your System.map? 

> These were copied from some Fedora Core development kernel version
> after 2.6.15-rc1 (last working one) in a box with 4 GB memory.

Please try vanilla 2.6.15rc2 as a reference at least.

-Andi
