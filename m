Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVFTPnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVFTPnz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 11:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVFTPnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 11:43:55 -0400
Received: from styx.suse.cz ([82.119.242.94]:41403 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261356AbVFTPns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 11:43:48 -0400
Date: Mon, 20 Jun 2005 17:43:47 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vincent Vanackere <vincent.vanackere@gmail.com>
Cc: linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>, thoffman@arnor.net,
       "Viktor A. Danilov" <__die@mail.ru>
Subject: Re: PROBLEM: atiremote input doesn`t register `device` & `driver` section in sysfs (/sys/class/input/event#)
Message-ID: <20050620154347.GC22152@ucw.cz>
References: <200504101921.28777.__die@mail.ru> <20050412074121.GE1371@kroah.com> <65258a580506050321f1eeab0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65258a580506050321f1eeab0@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2005 at 12:21:43PM +0200, Vincent Vanackere wrote:
> > On Sun, Apr 10, 2005 at 07:21:28PM +0600, Viktor A. Danilov wrote:
> > >
> > > PROBLEM: aiptek input doesn`t register `device` & `driver` section in sysfs (/sys/class/input/event#)
> > > REASON: `dev` - field not filled...
> > > SOLUTION: in linux/drivers/usb/input/aiptek.c write
> > >       aiptek->inputdev.dev = &intf->dev;
> > > before calling
> > >       input_register_device(&aiptek->inputdev);
> 
> Hi,
> 
>  The following (tested) patch fixes the exact same issue with the ATI
> Remote input driver.

Thanks; applied.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
