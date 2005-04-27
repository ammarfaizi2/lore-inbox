Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVD0Siz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVD0Siz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 14:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVD0Siy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 14:38:54 -0400
Received: from fire.osdl.org ([65.172.181.4]:21932 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261947AbVD0Sij (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 14:38:39 -0400
Date: Wed, 27 Apr 2005 11:38:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: luming.yu@intel.com, linux-kernel@vger.kernel.org, racing.guo@intel.com
Subject: Re: [PATCH]porting lockless mce from x86_64 to i386
Message-Id: <20050427113800.6be34642.akpm@osdl.org>
In-Reply-To: <20050427123852.GD12597@muc.de>
References: <200504261327.30928.luming.yu@intel.com>
	<20050427123852.GD12597@muc.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> On Tue, Apr 26, 2005 at 01:27:30PM +0800, Yu, Luming wrote:
> > 
> > Forward a patch :
> 
> Some comments: 
> 
> The asmlinkage on x86-64 is not really needed. You can remove
> the ifdef. fastcall is fine, although it is a nop.
> 
> The u64 tsc[NR CPUS] on the stack is a stack overflow with big
> NR_CPUS. I have
> a patch locally here to fix it, but you could just apply it
> anyways when you move the code. Fix is to use kmalloc here.
> 

OK, thanks.  Luming, could you please reissue the second patch, including
the above fixes as well as the two warning fixes which we discussed?

