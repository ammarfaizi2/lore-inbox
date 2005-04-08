Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVDHWTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVDHWTY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 18:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVDHWTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 18:19:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:24238 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261167AbVDHWTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 18:19:18 -0400
Date: Fri, 8 Apr 2005 15:18:02 -0700
From: Greg KH <gregkh@suse.de>
To: Roland Dreier <roland@topspin.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Reduce <linux/debugfs.h> dependencies
Message-ID: <20050408221801.GD3399@kroah.com>
References: <52ll87y9kl.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52ll87y9kl.fsf@topspin.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 09:16:58AM -0800, Roland Dreier wrote:
> The current <linux/debugfs.h> include file is a little fragile in that
> it is not self-contained and hence may cause compile warnings or
> errors depending on the files included before it, the kernel config
> and the architecture.  This patch makes things a little more robust by:
> 
>  - including <linux/types.h> to get definitions of u32, mode_t, and so on.
>  - forward declaring struct file_operations.
>  - including <linux/err.h> when CONFIG_DEBUG_FS is not set
> 
> The last change is particularly useful, as a kernel developer is
> likely to build with debugfs always enabled and never see the build
> breakage cased if debugfs is disabled.
> 
> Signed-off-by: Roland Dreier <roland@topspin.com>

Applied, thanks.

greg k-h
