Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264592AbUENXVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264592AbUENXVu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264335AbUENXSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:18:33 -0400
Received: from mail.kroah.org ([65.200.24.183]:41440 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264588AbUENXSC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:18:02 -0400
Date: Fri, 14 May 2004 16:17:12 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "R. J. Wysocki" <rjwysocki@sisk.pl>, ak@muc.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2(-mm1,-bk1): SMP bug on dual AMD64
Message-ID: <20040514231712.GA18108@kroah.com>
References: <200405142328.59471.rjwysocki@sisk.pl> <20040514160524.57dd9de4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040514160524.57dd9de4.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 04:05:24PM -0700, Andrew Morton wrote:
> "R. J. Wysocki" <rjwysocki@sisk.pl> wrote:
> >
> > I've just compiled the 2.6.6-mm2 kernel (with gcc-3.4) and tried to run it.  
> > Well, it generally works, but there seems to be an SMP bug that may be 
> > triggered with the help of a USB storage device (please see the attached 
> > log).  The device works fine in spite of it, though.
> > 
> > This bug seems to be present in the 2.6.6-mm1 and 2.6.6-bk1, but it is not 
> > present in the 2.6.6, apparently.
> > 
> > My system is a dual Opteron and I use an add-on USB 2.0 card based on the NEC 
> > chipset (the .config is attached).
> 
> The WARN_ON() backtrace is unrelated to USB - it is due to SCSI calling
> vmalloc/vfree with interrupts disabled.  People are working on that.
> 
> As for this:
> 
> May 14 23:57:09 chimera kernel: usb usb2: string descriptor 0 read error: -108
> May 14 23:57:09 chimera last message repeated 2 times
> 
> It has been reported before and I assume people are working it, but it
> would be nice to have confirmation of that...

It should be fixed in the patches I just sent to Linus.

thanks,

greg k-h
