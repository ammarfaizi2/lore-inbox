Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbVBPA2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVBPA2T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 19:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVBPA2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 19:28:19 -0500
Received: from mail.kroah.org ([69.55.234.183]:22987 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261929AbVBPA2P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 19:28:15 -0500
Date: Tue, 15 Feb 2005 15:44:15 -0800
From: Greg KH <greg@kroah.com>
To: dtor_core@ameritech.net
Cc: Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add "bus" symlink to class/block devices
Message-ID: <20050215234415.GA17680@kroah.com>
References: <20050215205344.GA1207@vrfy.org> <20050215220406.GA1419@vrfy.org> <d120d50005021514251492dd10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50005021514251492dd10@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 05:25:54PM -0500, Dmitry Torokhov wrote:
> On Tue, 15 Feb 2005 23:04:06 +0100, Kay Sievers <kay.sievers@vrfy.org> wrote:
> > 
> > -static int class_device_dev_link(struct class_device * class_dev)
> > -{
> > -       if (class_dev->dev)
> > -               return sysfs_create_link(&class_dev->kobj,
> > -                                        &class_dev->dev->kobj, "device");
> > -       return 0;
> > -}
> > -
> > -static void class_device_dev_unlink(struct class_device * class_dev)
> > -{
> > -       sysfs_remove_link(&class_dev->kobj, "device");
> > -}
> > -
> 
> Hi,
> 
> I can agree on dropping driver link but I think that the link to
> underlying real device is still needed.

It's still there, read the patch :)

thanks,

greg k-h
