Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbVAHFXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbVAHFXQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 00:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbVAHFXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 00:23:14 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:60287 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261790AbVAHFW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:22:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=aiYqrPIpynsM/7LYFmobXk8wou1b+HGFRhyeG5wnVtsvNrWjCkJHvON0rPfWngc2dOkj0ItA99Jj3I2XOGA1IaBvkGLOvCuSnQ7EcuJNHW/az8J+LavEfBg6OVNcarsI00RGlJ2t6zhJh44Ax/3N/B/j+CeC/9KT7X8CU4q/QYk=
Message-ID: <9e47339105010721225c0cfb32@mail.gmail.com>
Date: Sat, 8 Jan 2005 00:22:53 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org,
       DRI Devel <dri-devel@lists.sourceforge.net>
Subject: Re: chasing the four level page table
In-Reply-To: <20050106214159.GG16373@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339105010609175dabc381@mail.gmail.com> <m1vfaav340.fsf@muc.de>
	 <9e47339105010610362fd7fffe@mail.gmail.com>
	 <20050106193826.GC47320@muc.de>
	 <9e4733910501061205354c9508@mail.gmail.com>
	 <20050106214159.GG16373@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2005 16:41:59 -0500, Dave Jones <davej@redhat.com> wrote:
> No other device driver is also doing such lowlevel stuff with
> page tables directly afaics. drivers/char/drm seem to be the only drivers
> using [pgd|pmd|pte]_offset() routines.

On 6 Jan 2005 20:38:27 +0100, Andi Kleen <ak@muc.de> wrote:
> Perhaps we should add a get_user_phys() or somesuch for this.

I think this is a case where the memory manager is missing a function
that DRM needs. If there was a get_user_phys() function DRM wouldn't
need to walk the page tables.

-- 
Jon Smirl
jonsmirl@gmail.com
