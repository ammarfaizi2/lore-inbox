Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422854AbWBNXri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422854AbWBNXri (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 18:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422874AbWBNXri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 18:47:38 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:34260
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1422854AbWBNXrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 18:47:37 -0500
Date: Tue, 14 Feb 2006 15:47:36 -0800
From: Greg KH <greg@kroah.com>
To: Rob Landley <rob@landley.net>
Cc: Olivier Galibert <galibert@pobox.com>,
       ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       linux-kernel@vger.kernel.org
Subject: Re: Device enumeration (was Re: CD writing in future Linux (stirring up a hornets' nest))
Message-ID: <20060214234736.GB10590@kroah.com>
References: <43D7C1DF.1070606@gmx.de> <200602140023.15771.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060214104003.GA97714@dspnet.fr.eu.org> <200602141732.22712.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602141732.22712.rob@landley.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 05:32:22PM -0500, Rob Landley wrote:
> Changes to the kernel have already managed to break us twice 
> (switching /sys/class from real subdirectories to symlinks means we can't 
> just ignore symlinks when recursing down through directories anymore, which 
> is a problem because the existing symlinks form loops.

I've shown a simple way to handle this, so this should not be a problem
anymore.

> And deprecating /sbin/hotplug means we've got to bloat the code with
> netlink stuff.)  But we'll cope, and the user interface isn't
> changing.

Since when is /sbin/hotplug "depreciated"?  It still works just fine,
and isn't going anywhere anytime soon.

Turns out that some distros just don't want to use it, and use netlink
instead.  That should not stop you from using it if you wish, as the
kernel sure doesn't care one way or the other.

thanks,

greg k-h
