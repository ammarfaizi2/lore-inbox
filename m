Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbULUHIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbULUHIY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 02:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbULUHIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 02:08:24 -0500
Received: from gate.crashing.org ([63.228.1.57]:25519 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261514AbULUHIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 02:08:22 -0500
Subject: Re: /sys/block vs. /sys/class/block
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>, Jens Axboe <axboe@suse.de>
In-Reply-To: <20041220224950.GA21317@kroah.com>
References: <1103526532.5320.33.camel@gaston>
	 <20041220224950.GA21317@kroah.com>
Content-Type: text/plain
Date: Tue, 21 Dec 2004 08:07:50 +0100
Message-Id: <1103612870.21771.22.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-20 at 14:49 -0800, Greg KH wrote:
> On Mon, Dec 20, 2004 at 08:08:52AM +0100, Benjamin Herrenschmidt wrote:
> > I'm trying to understand why we have /sys/block instead
> > of /sys/class/block, and so far, I haven't found a single good argument
> > justifying it... It just messes up the so far logical layout of sysfs
> > for no apparent reason.
> 
> Because /sys/block happened before /sys/class did.  Al Viro converted
> the block layer before I got the struct class stuff working properly
> during 2.5.
> 
> And yes, I would like to convert the block layer to use the class stuff,
> but for right now, I can't as class devices don't allow
> sub-classes-devices, and getting to that work is _way_ down on my list
> of things to do.

but can't we at least artificially move it down to /sys/class anyway for
the sake of a sane userland API ?

Ben.

