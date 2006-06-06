Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWFFHcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWFFHcm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 03:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWFFHcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 03:32:42 -0400
Received: from mx1.suse.de ([195.135.220.2]:40083 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750822AbWFFHcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 03:32:41 -0400
Date: Tue, 6 Jun 2006 00:29:53 -0700
From: Greg KH <gregkh@suse.de>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH RFC 0/11] usbserial: Serial Core port.
Message-ID: <20060606072953.GC17682@suse.de>
References: <1149217397133-git-send-email-lcapitulino@mandriva.com.br> <20060602204839.GA31251@suse.de> <20060603190352.5249c934@home.brethil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060603190352.5249c934@home.brethil>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03, 2006 at 07:03:52PM -0300, Luiz Fernando N. Capitulino wrote:
> On Fri, 2 Jun 2006 13:48:39 -0700
> Greg KH <gregkh@suse.de> wrote:
> 
> | On Fri, Jun 02, 2006 at 12:03:06AM -0300, Luiz Fernando N.Capitulino wrote:
> | > 
> | >  Hi folks.
> | > 
> | >  This patch series is my first attempt to port the USB-Serial layer to the
> | > Serial Core API. Currently USB-Serial uses the TTY layer directly, duplicating
> | > code and solutions from the Serial Core implementation.
> | > 
> | >  The final (ported) USB-Serial code is simpler and cleaner. Now I'd like to know
> | > whether I'm doing it right or not.
> | > 
> | >  Note that this is a work in progress though. I've only ported the USB-Serial
> | > core and one of its drivers, the pl2303 one.
> | > 
> | >  Most of my questions and design decisions are adressed in the patches, please
> | > refer to them for details.
> | 
> | Nice first cut at this.  But please try to also convert 2 other drivers
> | at the same time to make sure that the model is right.  I'd suggest the
> | io_edgeport and the funsoft drivers.  io_edgeport because it is very
> | complex in that it doesn't share a single bulk in/out pair for every
> | port, but multiplexes them all through one pipe.  And funsoft because we
> | want to still be able to write usb-serial drivers that are this simple.
> 
>  I'd love to do that but, unfortunatally, USB-Serial cables are too
> expensive in Brazil (and I have no sure if I can find these ones in
> Curitiba).

No need to test fully, if it builds, I can test the io_edgeport driver,
and the funsoft one is pretty much a "nothing" driver.

thanks,

greg k-h
