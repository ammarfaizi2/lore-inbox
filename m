Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVBYUIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVBYUIr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 15:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVBYUIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 15:08:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:24455 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261273AbVBYUI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 15:08:27 -0500
Date: Fri, 25 Feb 2005 12:07:30 -0800
From: Greg KH <greg@kroah.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Stefan Eletzhofer <Stefan.Eletzhofer@eletztrick.de>
Subject: Re: [PATCH 2.6] Remove NULL client checks in rtc8564 driver
Message-ID: <20050225200729.GA25915@kroah.com>
References: <20050224224957.278cdcd8.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050224224957.278cdcd8.khali@linux-fr.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 10:49:57PM +0100, Jean Delvare wrote:
> Hi Stefan,
> 
> Several functions in your rtc8564 driver verify the non-NULLity of the
> i2c client that is passed to them. It doesn't seem to be necessary, as I
> can't think of any case where these functions could possibly be called
> with a NULL i2c client. As a matter of fact, I couldn't find any similar
> driver doing such checks.
> 
> My attention was brought on this by Coverity's SWAT which correctly
> noticed that three of these functions contain explicit or hidden
> dereferences of the i2c client pointer *before* the NULL check. I guess
> it wasn't a problem because the NULL case cannot happen (unless I miss
> something), but this still is confusing code.
> 
> Thus I propose the following changes:

Applied, thanks.

greg k-h
