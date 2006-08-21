Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWHUV4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWHUV4l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 17:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWHUV4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 17:56:41 -0400
Received: from are.twiddle.net ([64.81.246.98]:62688 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S1751224AbWHUV4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 17:56:40 -0400
Date: Mon, 21 Aug 2006 14:55:26 -0700
From: Richard Henderson <rth@twiddle.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alpha: replacing "extern inline"
Message-ID: <20060821215526.GA22930@twiddle.net>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org
References: <20060820235438.GY7813@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820235438.GY7813@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 01:54:38AM +0200, Adrian Bunk wrote:
> Why?

Because it inlines when it needs to, and does not generate
out of line code when its address is taken.

> Can someone tell me which of the Alpha "static inline"'s need for some 
> reason an __always_inline?

There shouldn't be any.

> Does the never defined __IO_EXTERN_INLINE still have any purpose?

It is defined.

$ grep 'define __IO_EXTERN_INLINE' * | wc -l
12


r~
