Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbTHTV0z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 17:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbTHTV0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 17:26:55 -0400
Received: from mail.kroah.org ([65.200.24.183]:37789 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262217AbTHTV0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 17:26:52 -0400
Date: Wed, 20 Aug 2003 14:26:26 -0700
From: Greg KH <greg@kroah.com>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [RFC] add class/video to fb drivers - Take 2
Message-ID: <20030820212626.GA4854@kroah.com>
References: <20030820191001.GA4185@kroah.com> <Pine.LNX.4.44.0308202044280.9662-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308202044280.9662-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 20, 2003 at 10:16:13PM +0100, James Simmons wrote:
> 
> > Ok, here's a smaller version of the patch, that doesn't break any fb
> > drivers.  Only those that have a struct device associated with them
> > should be changed (and that's just a 1 line addition).  I think it's
> > much better because of this.
> 
> Nice :-) Will apply tonight. Do you have any issues still with this 
> approach. You talked about the issue of dynamically creating the data. Is 
> this probnlem still present in this patch.

Well, it's not "ideal" but it will do for 2.6 to use this patch.  If you
look at the tty core, it's the same way that currently works.

Ideally in 2.7 I'd like to convert to have all fb drivers create the
fb_info structure dynamically, but that's much to big of a change to do
this late in the 2.6 development cycle.

thanks,

greg k-h
