Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbVKQW4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbVKQW4l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 17:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbVKQW4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 17:56:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25042 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964889AbVKQW4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 17:56:40 -0500
Date: Thu, 17 Nov 2005 14:56:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, mpm@selenic.com,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] skip initramfs check
Message-Id: <20051117145643.70dc5fad.akpm@osdl.org>
In-Reply-To: <20051117141432.GD9753@logos.cnet>
References: <20051117141432.GD9753@logos.cnet>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> The initramfs check at populate_rootfs() can consume significant time
> (several seconds) on slow/embedded platforms, since it has to decompress
> the image.
> 
> Add an option to skip it under CONFIG_EMBEDDED.
> 
> Is there a nicer way to achieve the same result?

I'd have thought that a __setup option would be preferable?  Remove an
ifdef, more flexible, and it's all __init code anyway.
