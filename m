Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269963AbUJSXBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269963AbUJSXBn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270042AbUJSWms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 18:42:48 -0400
Received: from cantor.suse.de ([195.135.220.2]:55701 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S270044AbUJSWkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:40:01 -0400
Date: Wed, 20 Oct 2004 00:39:57 +0200
From: Andi Kleen <ak@suse.de>
To: Werner Almesberger <werner@almesberger.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       ak@suse.de, Jaakko Hyv?tti <jaakko.hyvatti@iki.fi>
Subject: Re: [PATCH] no TIOCSBRK/TIOCCBRK in ia32 emulation on amd64
Message-ID: <20041019223957.GA22343@wotan.suse.de>
References: <20041019190705.J18873@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041019190705.J18873@almesberger.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 07:07:05PM -0300, Werner Almesberger wrote:
> In ia32 emulation, the amd64 kernel refuses the ioctls TIOCSBRK
> and TIOCCBRK with EINVAL. I've attached a patch that adds them to
> the compatibility list.
> 
> Since all architectures have these ioctls ("m68knommu" inherits
> them from "m68k", "um" from its host) and use the same code, I
> think adding them to compat_ioctl.h is the correct choice (as
> opposed to adding them to arch/x86_64/ia32/ia32_ioctl.c).
> 
> The patch is for 2.6.9. I've observed the problem the first time
> in 2.6.7.

Thanks, looks good.

-Andi
