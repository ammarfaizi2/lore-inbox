Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVETGZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVETGZz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 02:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVETGZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 02:25:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:26759 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261360AbVETGZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 02:25:49 -0400
Date: Thu, 19 May 2005 22:37:01 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Tom Rini <trini@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.12-rc4] Add EXPORT_SYMBOL for hotplug_path
Message-ID: <20050520053701.GA10697@kroah.com>
References: <20050519164323.GK3771@smtp.west.cox.net> <20050520051839.GB10394@kroah.com> <200505200018.24129.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505200018.24129.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2005 at 12:18:23AM -0500, Dmitry Torokhov wrote:
> On Friday 20 May 2005 00:18, Greg KH wrote:
> > On Thu, May 19, 2005 at 09:43:23AM -0700, Tom Rini wrote:
> > > If CONFIG_INPUT is set as a module, it will not load as hotplug_path is
> > > not a defined symbol.  Trivial fix is to EXPORT_SYMBOL hotplug_path.
> > > 
> > > Signed-off-by: Tom Rini <trini@kernel.crashing.org>
> > 
> > Ick, no, I thought we got rid of that usage.  no one should be calling
> > hotplug on their own, lots of bad things happen to udevd and HAL if they
> > do.
> > 
> > What caused the input code to be added back into the kernel?  I'll try
> > to go track that down...
> >
> 
> The change never made it into the kernel. And I need to finish proper
> input_dev sysfs conversion...

Ah, ok, thanks.  So I'll ACK the EXPORT_SYMBOL_GPL() version of this
patch for now.

thanks,

greg k-h
