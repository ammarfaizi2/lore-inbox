Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbTDKUCa (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 16:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbTDKUCa (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 16:02:30 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:45255 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261706AbTDKUC3 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 16:02:29 -0400
Date: Fri, 11 Apr 2003 13:16:29 -0700
From: Greg KH <greg@kroah.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: USB optical mouse on laptop causes bk12 boot to hang
Message-ID: <20030411201629.GR1821@kroah.com>
References: <20030407155858.GA2553@kroah.com> <Pine.LNX.4.44.0304101727410.1369-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304101727410.1369-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 10, 2003 at 05:35:34PM -0400, Robert P. J. Day wrote:
>   i have full module support selected in kernel configuration,
> but it seems that the required modules just aren't being loaded
> on demand.
> 
>   i just tested and "modprobe" seems to work, but i don't
> understand why none of this stuff is being loaded at boot
> time.

You probably need to tweak your initscripts to get this to happen.  I
know Red Hat needs this due to some changes in the way modules are used,
and the way modprobe has changed.

>   i'm still running under the new kernel, so i'm willing to
> entertain things i can check, but i have no X session (nvidia,
> which i haven't even *tried* to set up under 2.5.67).

So if you load the usb core, and then plug in your usb device, does it
all work after the machine has booted?

You don't have USB BIOS emulation support enabled in your BIOS do you?

And do you have this same problem on 2.4 kernels?

thanks,

greg k-h
