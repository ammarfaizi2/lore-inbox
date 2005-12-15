Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbVLOSiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbVLOSiL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 13:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbVLOSiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 13:38:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:18606 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750899AbVLOSiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 13:38:09 -0500
Date: Thu, 15 Dec 2005 10:37:44 -0800
From: Greg KH <greg@kroah.com>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ordering of suspend/resume for devices.  any clues, anyone?
Message-ID: <20051215183744.GB16574@kroah.com>
References: <20051215143124.GD14978@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215143124.GD14978@lkcl.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 02:31:24PM +0000, Luke Kenneth Casson Leighton wrote:
> [hi, please kindly cc me direct as i am deliberately subscribed with
> settings to not receive posts from this list, but if that is inconvenient
> for you to cc me, don't worry i can always look up the archives
> to keep track of replies, thank you.]
> 
> http://handhelds.org/moin/moin.cgi/BlueAngel
> 
> works.
> 
> am seeking some advice regarding power management - specifically
> the ordering of devices "resume" functions being called.
> 
> we have an LCD, and an ATI chip.  switching on the LCD powers up
> the ATI chip.
> 
> unfortunately, resume calls the ATI device initialisation
> _before_ the LCD resume initialisation.  the ATI chip's
> initialisation fails - naturally - because it's not even
> powered up.
> 
> of course - this can't be taken care of in userspace as an apm
> event because the framebuffer device cannot be a module [without
> terminating all running x-applications].
> 
> so.
> 
> possible solutions, as i see them:

<snip>

Known issue, I'd take this to the linux-pm mailing list instead, as the
people there are working on stuff for this.

thanks,

greg k-h
