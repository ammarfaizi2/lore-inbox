Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270115AbTGPEQy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 00:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270117AbTGPEQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 00:16:54 -0400
Received: from mail.kroah.org ([65.200.24.183]:44503 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270115AbTGPEQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 00:16:53 -0400
Date: Tue, 15 Jul 2003 21:29:16 -0700
From: Greg KH <greg@kroah.com>
To: Fredrik Tolf <fredrik@dolda2000.cjb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Input layer demand loading
Message-ID: <20030716042916.GC3929@kroah.com>
References: <200307131839.49112.fredrik@dolda2000.cjb.net> <20030714062217.GA20482@kroah.com> <200307141258.24458.fredrik@dolda2000.cjb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307141258.24458.fredrik@dolda2000.cjb.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 12:58:24PM +0200, Fredrik Tolf wrote:
> On Monday 14 July 2003 08.22, Greg KH wrote:
> > On Sun, Jul 13, 2003 at 06:39:49PM +0200, Fredrik Tolf wrote:
> > > Why does the input layer still not have on-demand module loading? How
> > > about applying this?
> >
> > What's wrong with the current hotplug interface for the input layer?  If
> > you want to implement this, add some input hotplug scripts to the
> > linux-hotplug package.
> 
> Correct me if I'm wrong, but AFAIK that can only be smoothly used to load 
> hardware driver modules.

In a way, yes.

> If the input layer userspace interface code has been compiled as modules, and 
> you have a ordinary (not hotplug) device, eg. a gameport joystick, can really 
> the hotplug interface be used to load joydev.o when /dev/input/js0 is opened?
> I don't use hotplugging that much, so I can't say that I'm sure about what it 
> can do, but in my perception of the hotplug system, it can't be used for 
> that.

No, you want to load the joydev.o driver when you plug in the gameport
joystick.  Which will be before you open the /dev node.

So I think it's working the way it is now, correct?

thanks,

greg k-h
