Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269214AbUI2Xh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269214AbUI2Xh7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 19:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269210AbUI2Xh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 19:37:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:10706 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269198AbUI2Xhg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 19:37:36 -0400
Date: Wed, 29 Sep 2004 16:35:07 -0700
From: Greg KH <greg@kroah.com>
To: Timo Ter?s <ext-timo.teras@nokia.com>
Cc: Robert Love <rml@novell.com>, linux-kernel@vger.kernel.org
Subject: Re: kobject events questions
Message-ID: <20040929233507.GB26845@kroah.com>
References: <415ABA96.6010908@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415ABA96.6010908@nokia.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 04:37:26PM +0300, Timo Ter?s wrote:
> Hi all,
> 
> I've been following the evolution of kobject events patch. This is 
> because I'd like to implement a netfilter target that is able to send an 
> event to userland using it.
> 
> There's a small description of it and some background in the netfilter 
> mailing list:
> http://lists.netfilter.org/pipermail/netfilter-devel/2004-August/016342.html
> 
> Now that the events are strictly associated with kobjects (the original 
> patch had a way to send arbitrary events) I have two choices:
> 
> 1) Send the events so that they are always associated with the network 
> devices class_device kobject. I guess this would be quite clean way to 
> do it, but it'd require adding a new signal type and would limit the 
> iptables target to be associated always with a interface.
> 
> 2) Create a device class that has virtual timer devices that trigger 
> events (ie. /sys/class/utimer). Each timer could have some attributes 
> (like expired, expire_time, etc.) and would emit "change" signals 
> whenever timer expires.
> 
> I'd like to hear what you think of the thing I'm trying to do?

Have you looked at the "connector" patch from Evgeniy Polyakov
<johnpol@2ka.mipt.ru> that was posted to Linux kernel?  After that goes
in, the kevent code will probably be tweaked to use that interface.

thanks,

greg k-h
