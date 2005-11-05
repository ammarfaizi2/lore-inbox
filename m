Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbVKECHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbVKECHW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 21:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbVKECHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 21:07:22 -0500
Received: from tim.rpsys.net ([194.106.48.114]:20612 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751381AbVKECHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 21:07:22 -0500
Subject: Re: ide-cs broken / udev magic
From: Richard Purdie <rpurdie@rpsys.net>
To: Greg KH <greg@kroah.com>
Cc: Damir Perisa <damir.perisa@solnet.ch>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Archlinux Developers <arch-dev@archlinux.org>
In-Reply-To: <20051104232854.GA21173@kroah.com>
References: <20051103220305.77620d8f.akpm@osdl.org>
	 <20051104071932.GA6362@kroah.com>
	 <200511050022.41472.damir.perisa@solnet.ch>
	 <20051104232854.GA21173@kroah.com>
Content-Type: text/plain
Date: Sat, 05 Nov 2005 02:06:52 +0000
Message-Id: <1131156412.8256.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-04 at 15:28 -0800, Greg KH wrote:
> On Sat, Nov 05, 2005 at 12:22:36AM +0100, Damir Perisa wrote:
> > as other distros use to ignore removable ide's. now i need to load the 
> > ide-cs module by hand (bad thing, as module should be loaded 
> > automagically with udev/hotplug) but on the other hand, no more 
> > dmesg-spamming, no freezes and also the node is created successfully 
> > after module is loaded. 
> 
> This shouldn't have changed the "autoload" capability of the module at
> all.  It should still being loaded with whatever means it was being
> loaded before.  But that's a distro specific question, not a
> linux-kernel issue.
> 
> > is there planed action to change ide-cs to work without making it being 
> > ignored ... without this exception that needs to be specified in udev 
> > rules? 
> 
> Yes, there are patches somewhere to fix this up, I'm trying to track
> them down.

This is a bug in the ide layer as CF pcmcia devices are marked as
removable but the devices (and the behaviour of ide-cs) does not fit the
Linux definition of such devices.

See this thread: http://lkml.org/lkml/2005/9/21/118

I'm hoping to work out a patch to change this in a manner acceptable to
everyone but haven't found time yet. I've not forgotten though.

Richard


