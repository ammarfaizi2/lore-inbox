Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266758AbUIOQSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266758AbUIOQSx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 12:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266756AbUIOQSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 12:18:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:1956 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266758AbUIOQQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 12:16:50 -0400
Date: Wed, 15 Sep 2004 09:09:30 -0700
From: Greg KH <greg@kroah.com>
To: "Giacomo A. Catenazzi" <cate@debian.org>
Cc: "Marco d'Itri" <md@Linux.IT>, linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
Message-ID: <20040915160930.GA21971@kroah.com>
References: <41473972.8010104@debian.org> <41474926.8050808@nortelnetworks.com> <20040914195221.GA21691@kroah.com> <414757FD.5050209@pixelized.ch> <20040914213506.GA22637@kroah.com> <20040914214552.GA13879@wonderland.linux.it> <20040914215122.GA22782@kroah.com> <20040914224731.GF3365@dualathlon.random> <20040914230409.GA23474@kroah.com> <414849CE.8080708@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414849CE.8080708@debian.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 03:55:26PM +0200, Giacomo A. Catenazzi wrote:
> 
> Real case: distribution boot script.
> It should work with non udev kernel, udev non modular kernel and
> udev very modular kernel.

That's a lot to ask for a simple script :)

Why not just pick one of those options and go with it?

> The script load (directly or not) a module
> and need the device impelmented by module.

Then do the 'sit and spin' method.  That works for all of the above
options, right?

> Old behaviour (modprobe "waits" for the creation of device):
> normal init.d script, with normal boot priorities.

Please realize that this "behaviour" is not guaranteed at all.  And in
fact will be changing in the future so that it is _not_ the way it will
work.

> New behaviour (dev.d). What I should do?
> My init.d script is loaded with priority XX, so
> I require that dev.d on my device is executed after
> boot priority XX (else I don't have the needed
> functionalities), also in case of non-udev or non modular kernel.
> How should I implement script in dev.d/?

dev.d is called by the kernel, not your script.  You don't have to set a
priority of when dev.d runs at all, it's not necessary.

> I see some design problems in dev.d/, or am I wrong?

What problems?

> PS: - What are the best (on topic) mailing list?

linux-hotplug-devel

>     - What do other distributions?

What do they do?  They just work :)

thanks,

greg k-h
