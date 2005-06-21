Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261997AbVFUIyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbVFUIyt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVFUIO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:14:27 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35090 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262059AbVFUHJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 03:09:38 -0400
Date: Tue, 21 Jun 2005 08:09:30 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH] devfs: Remove the tty_driver devfs_name field as it's no longer needed
Message-ID: <20050621080930.A30570@flint.arm.linux.org.uk>
Mail-Followup-To: Greg K-H <greg@kroah.com>, linux-kernel@vger.kernel.org,
	gregkh@suse.de
References: <11193354443273@kroah.com> <11193354441545@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <11193354441545@kroah.com>; from gregkh@suse.de on Mon, Jun 20, 2005 at 11:30:44PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 11:30:44PM -0700, Greg KH wrote:
> [PATCH] devfs: Remove the tty_driver devfs_name field as it's no longer needed
> 
> Also fixes all drivers that set this field.

Except for:

drivers/serial/serial_core.c:   normal->devfs_name      = drv->devfs_name;

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
