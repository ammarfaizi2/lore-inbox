Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262383AbVAZQqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbVAZQqs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 11:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVAZQog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 11:44:36 -0500
Received: from mail.kroah.org ([69.55.234.183]:11751 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262421AbVAZQnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 11:43:12 -0500
Date: Wed, 26 Jan 2005 08:42:12 -0800
From: Greg KH <greg@kroah.com>
To: Shawn Starr <shawn.starr@rogers.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2] I2C: lm80 driver improvement (From Aurelien) - Resubmit
Message-ID: <20050126164212.GA3366@kroah.com>
References: <200501260249.23583.shawn.starr@rogers.com> <200501260257.35605.shawn.starr@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501260257.35605.shawn.starr@rogers.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 02:57:35AM -0500, Shawn Starr wrote:
>  static inline unsigned char FAN_TO_REG(unsigned rpm, unsigned div)
>  {
> -	if (rpm == 0)
> +	if (rpm <= 0)

As was pointed out, this doesn't make any sense.

Care to redo the patch?

thanks,

greg k-h
