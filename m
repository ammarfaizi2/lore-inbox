Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266753AbUIOQSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266753AbUIOQSy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 12:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266775AbUIOQSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 12:18:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:2980 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266753AbUIOQQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 12:16:51 -0400
Date: Wed, 15 Sep 2004 09:12:29 -0700
From: Greg KH <greg@kroah.com>
To: "Giacomo A. Catenazzi" <cate@debian.org>
Cc: Tonnerre <tonnerre@thundrix.ch>, Ian Campbell <icampbell@arcom.com>,
       "Marco d'Itri" <md@Linux.IT>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: udev is too slow creating devices
Message-ID: <20040915161227.GC21971@kroah.com>
References: <414757FD.5050209@pixelized.ch> <20040914213506.GA22637@kroah.com> <20040914214552.GA13879@wonderland.linux.it> <20040914215122.GA22782@kroah.com> <20040914224731.GF3365@dualathlon.random> <20040914230409.GA23474@kroah.com> <414849CE.8080708@debian.org> <1095258966.18800.34.camel@icampbell-debian> <20040915152019.GD24818@thundrix.ch> <4148637F.9060706@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4148637F.9060706@debian.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 05:45:03PM +0200, Giacomo A. Catenazzi wrote:
> 
> 
> Tonnerre wrote:
> >
> >On Wed, Sep 15, 2004 at 03:36:06PM +0100, Ian Campbell wrote:
> >
> >>I wonder if it would be feasible for modprobe (or some other utility) to
> >>have a new option: --wait-for=/dev/something which would wait for the
> >>device node to appear. Perhaps by:
> >>	- some mechanism based on HAL, DBUS, whatever
> >>	- dnotify on /dev/?
> >>	- falling back to spinning and waiting.
> >
> >
> >This would  end up  as hideous misfeature  as you can't  guarantee the
> >device to show up *at* *all*.
> >
> >The reason udev is there is that we can dynamically respond to created
> >device nodes and  devices that show up. They  might have changed since
> >the last boot. Maybe they don't show up at all.
> >
> >Thus you should trigger your actions from /etc/dev.d.
> 
> It is right.
> But an option --wait would be sufficient.
> This option will require modprobe to wait (with a timeout of
> x seconds) that hotplug event finish (so if device is created or
> not is no more a problem).
> Ideally this should be done modifing only hotplug and IMHO
> should be enabled by default.

Um, I don't think this is posible to do at all.  But hey, go ahead and
implement it to prove me wrong :)

good luck,

greg k-h
