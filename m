Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbUEBGVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbUEBGVl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 02:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbUEBGVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 02:21:41 -0400
Received: from mail.kroah.org ([65.200.24.183]:43405 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261263AbUEBGVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 02:21:40 -0400
Date: Sat, 1 May 2004 22:10:15 -0700
From: Greg KH <greg@kroah.com>
To: "Kevin O'Connor" <kevin@koconnor.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] support I2C_M_NO_RD_ACK in i2c-algo-bit
Message-ID: <20040502051015.GB31886@kroah.com>
References: <20040425180645.GA32199@ohio.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040425180645.GA32199@ohio.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2004 at 02:06:45PM -0400, Kevin O'Connor wrote:
> This is a message resend - the original didn't make it to lkml.
> 
> Hi Greg,
> 
> I have an I2C device (Samsung ks0127 video grabber) with a peculiar i2c
> implementation.  When reading bytes, it only senses for the stop condition
> in the place where the acknowledge bit should be.  So, to properly support
> this device acks need to be turned off during reads.
> 
> There is an I2C_M_NO_RD_ACK bit already defined in i2c.h which appears to
> be what I want.  Unfortunately it doesn't seem to be used anywhere in the
> current tree.  At the end of this message is a patch to teach i2c_algo_bit
> to honor the bit.

Applied, thanks.

greg k-h
