Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbVBPDSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbVBPDSl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 22:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbVBPDSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 22:18:41 -0500
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:6293 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261967AbVBPDSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 22:18:39 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] add "bus" symlink to class/block devices
Date: Tue, 15 Feb 2005 22:18:36 -0500
User-Agent: KMail/1.7.2
Cc: Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org
References: <20050215205344.GA1207@vrfy.org> <d120d50005021514251492dd10@mail.gmail.com> <20050215234415.GA17680@kroah.com>
In-Reply-To: <20050215234415.GA17680@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502152218.37464.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 February 2005 18:44, Greg KH wrote:
> On Tue, Feb 15, 2005 at 05:25:54PM -0500, Dmitry Torokhov wrote:
> > On Tue, 15 Feb 2005 23:04:06 +0100, Kay Sievers <kay.sievers@vrfy.org> wrote:
> > > 
> > > -static int class_device_dev_link(struct class_device * class_dev)
> > > -{
> > > -       if (class_dev->dev)
> > > -               return sysfs_create_link(&class_dev->kobj,
> > > -                                        &class_dev->dev->kobj, "device");
> > > -       return 0;
> > > -}
> > > -
> > > -static void class_device_dev_unlink(struct class_device * class_dev)
> > > -{
> > > -       sysfs_remove_link(&class_dev->kobj, "device");
> > > -}
> > > -
> > 
> > Hi,
> > 
> > I can agree on dropping driver link but I think that the link to
> > underlying real device is still needed.
> 
> It's still there, read the patch :)
> 

Oops, missed that. Sorry.

-- 
Dmitry
