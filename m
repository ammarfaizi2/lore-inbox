Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262219AbVCITV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbVCITV5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 14:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbVCITR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 14:17:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:18384 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262219AbVCITMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 14:12:46 -0500
Date: Wed, 9 Mar 2005 11:12:30 -0800
From: Greg KH <greg@kroah.com>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: Wen Xiong <wendyx@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [ patch 6/7] drivers/serial/jsm: new serial device driver
Message-ID: <20050309191230.GA27501@kroah.com>
References: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D9E9@minimail.digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D9E9@minimail.digi.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 11:42:31AM -0600, Kilau, Scott wrote:
> Hi Wendy, Greg, all,
> 
> If IBM intends on our DPA management program to work for the JSM
> products, the ioctls are needed.

Wendy, what is IBM's stance on this?

> DPA support is a requirement for all Digi drivers, so it would
> not be possible for me to remove them from my "dgnc" version
> of the driver.

"requirement" from whom and to who?  The Linux kernel community?

> For the JSM driver, its up to you whether you feel its needed or not.
> 
> However, I would like to mention that the DIGI drivers that currently
> reside in the kernel sources *do* reserve that ioctl space,
> and is acknowledged by "Documentation/ioctl-number.txt":
> > d'     F0-FF   linux/digi1.h
> 
> I understand that the list is not a reservation list,
> but a current list of potential ioctl conflicts...

It's not a reservation issue, it's the fact that we don't want to allow
new ioctls, and if we do, they had better work properly (your
implementation does not.)

thanks,

greg k-h
