Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbVI2U1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbVI2U1m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 16:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbVI2U1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 16:27:42 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:2458 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932436AbVI2U1m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 16:27:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jofftQ+J3z74lK80a3/UxiQs0GRXtjzwMU0ROH1gyLHht+6zYNGUf/KKYLiTTFDhJcP3zpsMWTJm10Ppv4M4D/64tl/wl62xOy7VuYoA4uQjYtHfLs+TOKd0EFrPsfEvLUml4nDg6xuFcG2HWp7BtBMofJATdFquuLKBlSYdb8U=
Message-ID: <12c511ca050929132743f946f1@mail.gmail.com>
Date: Thu, 29 Sep 2005 13:27:41 -0700
From: Tony Luck <tony.luck@gmail.com>
Reply-To: Tony Luck <tony.luck@gmail.com>
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] ia64 basic __user annotations
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050928231213.GG7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050928231213.GG7992@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/05, Al Viro <viro@ftp.linux.org.uk> wrote:
>         * uintptr_t is unsigned long, not long

> -       long __gu_err = -EFAULT, __gu_val = 0;                                          \
> -                                                                                       \
> +       long __gu_err = -EFAULT;                                                        \
> +       unsigned long __gu_val = 0;                                                     \

Too subtle for me ... what's happening here?  If you change this, then
should you also change "register long __gu_r9 asm ("r9");" in __get_user_size
to be unsigned long as well?

-Tony
