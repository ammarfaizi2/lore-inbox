Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbTJGRxV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 13:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262553AbTJGRxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 13:53:21 -0400
Received: from mail.kroah.org ([65.200.24.183]:57834 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262551AbTJGRxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 13:53:18 -0400
Date: Tue, 7 Oct 2003 10:53:10 -0700
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs. udev
Message-ID: <20031007175310.GC1956@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <yw1xad8dfcjg.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xad8dfcjg.fsf@users.sourceforge.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 07, 2003 at 02:38:27PM +0200, Måns Rullgård wrote:
> 
> I noticed this in the help text for devfs in 2.6.0-test6:
> 
> 	  Note that devfs has been obsoleted by udev,
> 	  <http://www.kernel.org/pub/linux/utils/kernel/hotplug/>.
> 	  It has been stripped down to a bare minimum and is only provided for
> 	  legacy installations that use its naming scheme which is
> 	  unfortunately different from the names normal Linux installations
> 	  use.
> 
> Now, this puzzles me, for a few of reasons.  Firstly, not long ago,
> devfs was spoken of as the way to go, and all drivers were rewritten
> to support it.  Why this sudden change?

A few things happened:
	- the devfs maintainer/author disappeared and stoped maintaining
	  the code.
	- devfs was found to have unfixable bugs
	- it was determined that the same thing could be done in
	  userspace (like udev.)
	  
> Secondly, that link only leads me to a package describing itself as an
> experimental proof-of-concept thing, not to be used for anything
> serious.  How can something that incomplete obsolete a working system
> like devfs?

I didn't send that patch to the kernel to mark devfs as such.

Actually devfs is still very much "experimental" and "proof-of-concept"
if you have ever looked at it's code :)

> Thirdly, udev appears to respond to hotplug events only.  How is it
> supposed to handle device files not corresponding to any physical
> device?

Like what?  Anything that shows up in sysfs, udev will handle.  It's
only a matter of getting everything to show up in sysfs now...  It's
almost all there.

> Finally, I quite liked the idea of a virtual filesystem for /dev.  It
> reduced the clutter quite a bit.  As for the naming scheme, it could
> easily be changed.

devfs's naming scheme could easily be changed?  Hahaha...

udev will be a major factor of improvement for changable naming schemes.
Please read the OLS paper for more details.

thanks,

greg k-h
