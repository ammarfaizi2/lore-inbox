Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932608AbVLNO3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608AbVLNO3X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 09:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbVLNO3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 09:29:22 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19467 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932609AbVLNO3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 09:29:21 -0500
Date: Wed, 14 Dec 2005 14:29:10 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Anderson Briglia <briglia.anderson@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 1/5] [RFC] Add MMC password protection (lock/unlock) support
Message-ID: <20051214142910.GC7124@flint.arm.linux.org.uk>
Mail-Followup-To: Anderson Briglia <briglia.anderson@gmail.com>,
	linux-kernel@vger.kernel.org
References: <e55525570512140530u3601e325ha63b1db10209dbcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e55525570512140530u3601e325ha63b1db10209dbcc@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 09:30:49AM -0400, Anderson Briglia wrote:
>  /*
> - * This currently matches any MMC driver to any MMC card - drivers
> - * themselves make the decision whether to drive this card in their
> - * probe method.  However, we force "bad" cards to fail.
> + * This currently matches any MMC driver to any MMC card - drivers themselves
> + * make the decision whether to drive this card in their probe method. However,
> + * we force "bad" cards to fail.
> + *
> + * We also fail for all locked cards; drivers expect to be able to do block I/O
> + * still on probe(), which is not possible while the card is locked. Device
> + * probing must be triggered sometime later to make the card available to the
> + * block driver.
>   */

Please arrange comments to wrap _before_ the last column, as per the
original.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
