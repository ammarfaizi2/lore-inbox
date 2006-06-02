Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbWFBUwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWFBUwm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 16:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbWFBUwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 16:52:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:40678 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964890AbWFBUwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 16:52:41 -0400
Date: Fri, 2 Jun 2006 13:50:14 -0700
From: Greg KH <gregkh@suse.de>
To: "Luiz Fernando N.Capitulino" <lcapitulino@mandriva.com.br>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH 8/11] usbserial: pl2303: Ports tty functions.
Message-ID: <20060602205014.GB31251@suse.de>
References: <1149217397133-git-send-email-lcapitulino@mandriva.com.br> <1149217398434-git-send-email-lcapitulino@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149217398434-git-send-email-lcapitulino@mandriva.com.br>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2006 at 12:03:14AM -0300, Luiz Fernando N.Capitulino wrote:
>   2. The new pl2303's set_termios() can (still) sleep. Serial Core's
>      documentation says that that method must not sleep, but I couldn't find
>      where in the Serial Core code it's called in atomic context. So, is this
>      still true? Isn't the Serial Core's documentation out of date?

If this is true then we should just stop the port right now, as the USB
devices can not handle this.  They need to be able to sleep to
accomplish this functionality.

Russell, is this a requirement of the serial layer?  Why?

thanks,

greg k-h
