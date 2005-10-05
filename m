Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030402AbVJEWzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030402AbVJEWzg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 18:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030409AbVJEWzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 18:55:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:24780 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030402AbVJEWzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 18:55:35 -0400
Date: Wed, 5 Oct 2005 15:55:04 -0700
From: Greg KH <gregkh@suse.de>
To: dtor_core@ameritech.net
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>
Subject: Re: [patch 08/28] Input: prepare to sysfs integration
Message-ID: <20051005225504.GA3566@suse.de>
References: <20050915070131.813650000.dtor_core@ameritech.net> <20050915070302.813567000.dtor_core@ameritech.net> <20051005220316.GA2932@suse.de> <d120d5000510051517k28bbb1f9v3c7ec7448608926@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000510051517k28bbb1f9v3c7ec7448608926@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 05:17:00PM -0500, Dmitry Torokhov wrote:
> On 10/5/05, Greg KH <gregkh@suse.de> wrote:
> > On Thu, Sep 15, 2005 at 02:01:39AM -0500, Dmitry Torokhov wrote:
> > > Input: prepare to sysfs integration
> > >
> > > Add struct class_device to input_dev; add input_allocate_dev()
> > > to dynamically allocate input devices; dynamically allocated
> > > devices are automatically registered with sysfs.
> > >
> > > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> >
> > Ok, I've applied this one, and the other "convert the input drivers to
> > be dynamic" to my tree, as this is all great work.
> >
> > I'll work on the last few patches that you have, with regard to how to
> > tie it into sysfs "properly" now, and get back to you, just wanted to
> > apply all of these, so we have a common base to work on.
> >
> 
> Greg,
> 
> Could you please drop these patches for a while? Or maybe just don't
> push them to Linus yet.

How about I hold on to them, until you send me replacements for them?
I'm using quilt so I can just drop them and add your new ones very
easily.  I will not push them to Linus until you and Vojtech say it's ok
for me to do so.

> The reason is that I want to change input_allocate_device to take
> bitmap of supported events. This way I could allocate ABS tables
> dynamically at the same time I allocate input_dev itself and it will
> simplify error handling logic in drivers and it will save I think 1260
> bytes per input_dev structure which is nice. And I don't want to go
> through all subsystems yet again soI want to fold into my input
> dynalloc patch...

That sounds good.

thanks,

greg k-h
