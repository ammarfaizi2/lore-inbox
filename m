Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbWAaHmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbWAaHmL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 02:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbWAaHmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 02:42:10 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:58074
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S965056AbWAaHmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 02:42:09 -0500
Date: Mon, 30 Jan 2006 23:42:04 -0800
From: Greg KH <greg@kroah.com>
To: iSteve <isteve@rulez.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udevstart surprisingly slow
Message-ID: <20060131074204.GA26356@kroah.com>
References: <43DE8D5E.2040905@rulez.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DE8D5E.2040905@rulez.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2006 at 11:04:14PM +0100, iSteve wrote:
> Greetings,
> I've recently upgraded udev from 063 to 082 and then 084.
> 
> With 063, startup of udev was near-instant; with both 082 and 084, it 
> takes a significant ammount of time (~15s) to create the base devices 
> using udevstart or udevsynthesize (this one is taken from Debian, which 
> apparently in turn taken it from SuSE; the rest of codebase is vanilla).

With the 2.6.15 kernel, udevstart is no longer needed.  Please use the
recommended shell script instead (as posted to the linux-hotplug-devel
mailing list.)

> This issue appears on kernel 2.6.15.1 with SquashFS 2.2r2, SWSUP2 2.2 
> and VesaFB-TNG 1.0-rc1-r3 patches.

All of which are not patches included in the mainline kernel.  Can you
try it without these?

> The init script used simply mounts 10MiB tmpfs onto /dev, creates 
> /dev/.udev/{db,queue} directories, then runs udevd --daemon and then 
> udevsynthesize or udevstart (tried both, same result).

Again, don't do that :)

Also, udev specific questions like these are best asked on the
linux-hotplug-devel mailing list, as the udev documentation states.

thanks,

greg k-h
