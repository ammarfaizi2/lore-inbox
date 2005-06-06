Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbVFFXnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVFFXnE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 19:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbVFFXSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 19:18:07 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:38486 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261733AbVFFW4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 18:56:05 -0400
Date: Mon, 6 Jun 2005 15:55:49 -0700
From: Greg KH <gregkh@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: tom.l.nguyen@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, roland@topspin.com
Subject: Re: pci_enable_msi() for everyone?
Message-ID: <20050606225548.GA11184@suse.de>
References: <20050603224551.GA10014@kroah.com> <20050605.124612.63111065.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050605.124612.63111065.davem@davemloft.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2005 at 12:46:12PM -0700, David S. Miller wrote:
> From: Greg KH <gregkh@suse.de>
> Date: Fri, 3 Jun 2005 15:45:51 -0700
> 
> > Now I know the e1000 driver would have to specifically disable MSI for
> > some of their broken versions, and possibly some other drivers might
> > need this, but the downside seems quite small.
> > 
> > Or am I missing something pretty obvious here?
> 
> This is totally undesirable.  We don't want the device sending
> out MSI messages unless the driver for it explicitly knows
> that it is operating the device in this mode.

Why would it matter?  The driver shouldn't care if the interrupts come
in via the standard interrupt way, or through MSI, right?  And if it
does, it could always use a function like the one I proposed to set up a
different irq handler.

> TG3 will disable MSI for several chip variants as well.  It will
> also disable MSI if it's internal self-test of MSI functionality
> fails.

That's fine to disable msi, I don't have an issue with that.  I'm just
getting pushback from some vendors as to why MSI isn't explicitly
enabled by default and I don't have any solid answers.

thanks,

greg k-h
