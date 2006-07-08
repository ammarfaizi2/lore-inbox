Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWGHNy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWGHNy6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 09:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbWGHNy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 09:54:58 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:47021 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S964831AbWGHNy5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 09:54:57 -0400
Subject: Re: [RFC][PATCH 1/2] firmware version management: add
	firmware_version()
From: Marcel Holtmann <marcel@holtmann.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Martin Langer <martin-langer@gmx.de>, linux-kernel@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de
In-Reply-To: <1152365514.3120.46.camel@laptopd505.fenrus.org>
References: <20060708130904.GA3819@tuba>
	 <1152365514.3120.46.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 15:49:57 +0200
Message-Id: <1152366597.29506.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arjan,

> > It would be good if a driver knows which firmware version will be 
> > written to the hardware. I'm talking about external firmware files 
> > claimed by request_firmware(). 
> > 
> > We know so many different firmware files for bcm43xx and it becomes 
> > more and more complicated without some firmware version management.
> > 
> > This patch can create the md5sum of a firmware file. Then it looks into 
> > a table to figure out which version number is assigned to the hashcode.
> > That table is placed in the driver code and an example for bcm43xx comes 
> > in my next mail. Any comments?
> 
> why does this have to happen on the kernel side? Isn't it a lot easier
> and better to let the userspace side of things do this work, and even
> have a userspace file with the md5->version mapping? Or are there some
> practical considerations that make that hard to impossible?

I fully agree that we shouldn't put firmware versioning into the kernel
drivers. The pattern you give to request_firmware() can be mapped to any
file on the file system. And you also have the link to the device object
and I prefer you export a sysfs file for the version so that the helper
application loading the firmware can pick the right file.

Regards

Marcel


