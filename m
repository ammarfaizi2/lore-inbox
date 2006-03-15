Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWCORPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWCORPS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 12:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWCORPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 12:15:18 -0500
Received: from iabervon.org ([66.92.72.58]:36618 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750715AbWCORPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 12:15:16 -0500
Date: Wed, 15 Mar 2006 12:16:31 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Stephen Hemminger <shemminger@osdl.org>
cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: Module Ref Counting & ibmphp
In-Reply-To: <20060314162104.5370b20d@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0603151205460.6773@iabervon.org>
References: <20060314224700.41242.qmail@web52612.mail.yahoo.com>
 <20060315000212.GB6533@kroah.com> <20060314162104.5370b20d@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2006, Stephen Hemminger wrote:

> The proper way to prevent unloading is just not to have a module exit routine,
> rather than causing ref count to be off. The the module subsystem will
> mark it as unsafe to unload. Unless it wants to allow unsafe forced unload.
> But IMHO either it needs to be safe to unload or not allow it.

Maybe add a comment where module_exit was, saying that the hardware can't 
be made to behave without the module, so people don't think that debugging 
the module could make it safely unloadable?

	-Daniel
*This .sig left intentionally blank*
