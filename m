Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965893AbWKOHGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965893AbWKOHGd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966059AbWKOHGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:06:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:2196 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965893AbWKOHGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:06:32 -0500
Date: Tue, 14 Nov 2006 22:50:52 -0800
From: Greg KH <greg@kroah.com>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [Patch -mm 2/5] driver core: Introduce device_move(): move a device to a new parent.
Message-ID: <20061115065052.GC23810@kroah.com>
References: <20061114113208.74ec12c4@gondolin.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114113208.74ec12c4@gondolin.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 11:32:08AM +0100, Cornelia Huck wrote:
> From: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> Provide a function device_move() to move a device to a new parent device. Add
> auxilliary functions kobject_move() and sysfs_move_dir().

At first glance, this looks sane, but for the kobject_move function, we
are not notifying userspace that something has changed here.

Is that ok?

How will udev and HAL handle something like this without being told
about it?  When the device eventually goes away, I think they will be
very confused.

thanks,

greg k-h
