Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbVIACaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbVIACaG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 22:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbVIACaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 22:30:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:16343 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965035AbVIACaF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 22:30:05 -0400
Date: Wed, 31 Aug 2005 19:29:38 -0700
From: Greg KH <greg@kroah.com>
To: Henrik Persson <root@fulhack.info>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Dominik Brodowski <linux@brodo.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.13
Message-ID: <20050901022938.GA27209@kroah.com>
References: <Pine.LNX.4.58.0508281708040.3243@g5.osdl.org> <4314E07F.2080807@fulhack.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4314E07F.2080807@fulhack.info>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 12:41:03AM +0200, Henrik Persson wrote:
> Linus Torvalds wrote:
> > There it is. 
> > 
> > The most painful part of 2.6.13 is likely to be the fact that we made x86
> > use the generic PCI bus setup code for assigning unassigned resources.  
> > That uncovered rather a lot of nasty small details, but should also mean
> > that a lot of laptops in particular should be able to discover PCI devices
> > behind bridges that the BIOS hasn't set up.
> > 
> > We've hopefully fixed up all the problems that the longish -rc series
> > showed, and it shouldn't be that painful, but if you have device problems,
> > please make a report that at a minimum contains the unified diff of the
> > output of "lspci -vvx" running on 2.6.12 vs 2.6.13. That might give us
> > some clues.
> 
> Well. 2.6.13 won't boot if I have my Netgear WG511 in the cardbus slot.
> It boots just fine if it isn't inserted, though. If I insert it later
> on, the computer will freeze and won't respond, just like it does on boot.
> 
> 2.6.12.5 works just fine, and I just did make oldconfig and used the
> defaults (except for the hardware monitoring).
> 
> Suggestions, anyone?

Can you try the patch posted to lkml at:
	http://marc.theaimsgroup.com/?l=linux-kernel&m=112541348008047&w=2
from Ivan to see if that helps this?

thanks,

greg k-h
