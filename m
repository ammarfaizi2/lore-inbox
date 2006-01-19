Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161119AbWASAxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161119AbWASAxe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 19:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161123AbWASAxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 19:53:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:56459 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161119AbWASAxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 19:53:33 -0500
Date: Wed, 18 Jan 2006 16:53:16 -0800
From: Greg KH <greg@kroah.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: RFC: ipath ioctls and their replacements
Message-ID: <20060119005316.GA26884@kroah.com>
References: <1137631411.4757.218.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137631411.4757.218.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 04:43:31PM -0800, Bryan O'Sullivan wrote:
> For EEPROM/flash management:
> 
>         READ_EEPROM reads the flash.  WRITE_EEPROM writes it.  I don't
>         see a standard way of doing this in the kernel; many drivers
>         provide their own private ioctls, some on dedicated special
>         files.  I think that using read and write instead would be okay
>         (with a small qualm about semantics), but this idea makes an
>         influential coworker barf violently.  I can't see how we could
>         use the ethtool flash interface: the low-level driver doesn't
>         look like a regular net device, and we support partial updates
>         of the flash.

Use the firmware subsystem for this.  It uses sysfs so ioctl needed at
all.

thanks,

greg k-h
