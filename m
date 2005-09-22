Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030314AbVIVNRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030314AbVIVNRU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030320AbVIVNRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:17:20 -0400
Received: from colin.muc.de ([193.149.48.1]:37642 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1030314AbVIVNRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:17:19 -0400
Date: 22 Sep 2005 15:17:14 +0200
Date: Thu, 22 Sep 2005 15:17:14 +0200
From: Andi Kleen <ak@muc.de>
To: Zachary Amsden <zach@vmware.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeffrey Sheldon <jeffshel@vmware.com>,
       Ole Agesen <agesen@vmware.com>, Shai Fultheim <shai@scalex86.org>,
       Andrew Morton <akpm@odsl.org>, Jack Lo <jlo@vmware.com>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Chris Wright <chrisw@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH 3/3] Gdt page isolation
Message-ID: <20050922131714.GA97170@muc.de>
References: <200509220749.j8M7nINV001001@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509220749.j8M7nINV001001@zach-dev.vmware.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  	 * This grunge runs the startup process for
>  	 * the targeted processor.
>  	 */
> +	cpu_gdt_descr[cpu].address = __get_free_page(GFP_KERNEL|__GFP_ZERO);

I can see why don't check it for NULL, but it's a ugly reason
and would be better fixed. It at least needs a comment.

-Andi (who would still prefer just going back to the array
in head.S - would work as well and waste less memory) 
>  
>  	atomic_set(&init_deasserted, 0);
