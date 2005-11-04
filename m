Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbVKDX3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbVKDX3e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbVKDX3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:29:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:53940 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750989AbVKDX3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:29:33 -0500
Date: Fri, 4 Nov 2005 15:28:54 -0800
From: Greg KH <greg@kroah.com>
To: Damir Perisa <damir.perisa@solnet.ch>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Archlinux Developers <arch-dev@archlinux.org>
Subject: Re: ide-cs broken / udev magic
Message-ID: <20051104232854.GA21173@kroah.com>
References: <20051103220305.77620d8f.akpm@osdl.org> <20051104071932.GA6362@kroah.com> <200511050022.41472.damir.perisa@solnet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511050022.41472.damir.perisa@solnet.ch>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 12:22:36AM +0100, Damir Perisa wrote:
> as other distros use to ignore removable ide's. now i need to load the 
> ide-cs module by hand (bad thing, as module should be loaded 
> automagically with udev/hotplug) but on the other hand, no more 
> dmesg-spamming, no freezes and also the node is created successfully 
> after module is loaded. 

This shouldn't have changed the "autoload" capability of the module at
all.  It should still being loaded with whatever means it was being
loaded before.  But that's a distro specific question, not a
linux-kernel issue.

> is there planed action to change ide-cs to work without making it being 
> ignored ... without this exception that needs to be specified in udev 
> rules? 

Yes, there are patches somewhere to fix this up, I'm trying to track
them down.

thanks,

greg k-h
