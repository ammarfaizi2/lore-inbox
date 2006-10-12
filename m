Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWJLSwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWJLSwt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 14:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWJLSws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 14:52:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25063 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750873AbWJLSws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 14:52:48 -0400
Date: Thu, 12 Oct 2006 11:52:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver core: fix error handling in device_bind_driver()
Message-Id: <20061012115240.d856e254.akpm@osdl.org>
In-Reply-To: <200610120105.56022.dtor@insightbb.com>
References: <200610120105.56022.dtor@insightbb.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006 01:05:55 -0400
Dmitry Torokhov <dtor@insightbb.com> wrote:

> Subject: Driver core: fix error handling in device_bind_driver()
> From: Dmitry Torokhov <dtor@insightbb.com>
> 
> When link creation fails we not only need to signal error
> but also remove device from driver's list of bound devices.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
>  drivers/base/dd.c |   29 ++++++++++++++++++-----------
>  1 files changed, 18 insertions(+), 11 deletions(-)
> 
> Index: work/drivers/base/dd.c
> ===================================================================
> --- work.orig/drivers/base/dd.c
> +++ work/drivers/base/dd.c

This code has undergone basic restructuring in Greg's development tree.  A
patch against rc1-mm1 would apply.
