Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269628AbUICLnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269628AbUICLnq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 07:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269630AbUICLnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 07:43:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:19158 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269628AbUICLnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 07:43:45 -0400
Date: Fri, 3 Sep 2004 13:41:28 +0200
From: Greg KH <greg@kroah.com>
To: Roeland Moors <roelandmoors@telenet.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev removable media
Message-ID: <20040903114128.GA13192@kroah.com>
References: <20040903112833.GA3584@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040903112833.GA3584@laptop>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 01:28:33PM +0200, Roeland Moors wrote:
> I have an USB zip drive in combination with udev.
> 
> When I connect the drive with a disk inserted, everything works
> fine. Here is the udev rule:
> BUS="usb", SYSFS{product}="USB Zip 750", KERNEL="sd?1",
> NAME="%k", SYMLINK="zip"
> 
> When connecting the drive without a disk the symlink is not
> created. This is ok, beceause there is no disk.
> 
> But if I now insert a disk, there is still no symlink?

That's because we don't get a "media inserted" event, sorry.

> I've search a bit on google and if I understand correctly the
> main problem is the SCSI protocol.
> 
> Is there a solution to this problem?

You can use the "all_partitions" solution in udev to always create the
partition device nodes.  See the udev manpage for more information.

thanks,

greg k-h
