Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272331AbTG3XbU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 19:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272332AbTG3XbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 19:31:20 -0400
Received: from mail.kroah.org ([65.200.24.183]:17291 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272331AbTG3XbR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 19:31:17 -0400
Date: Wed, 30 Jul 2003 16:28:43 -0700
From: Greg KH <greg@kroah.com>
To: Philip Graham Willoughby <pgw99@doc.ic.ac.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem ever
Message-ID: <20030730232843.GA5764@kroah.com>
References: <20030729151701.GA6795@bodmin.doc.ic.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030729151701.GA6795@bodmin.doc.ic.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 04:17:03PM +0100, Philip Graham Willoughby wrote:
> Hi all,
> 
> This patch adds an abstraction layer for programmable LED devices,
> hardware drivers for the Status LEDs found on some Intel PIIX4E based
> server hardware (notably the ISP1100 1U rackmount server) and LEDs wired
> to the parallel port data lines.

Some minor comments:
	- read Documentation/CodingStyle and apply it to your code.
	- fix up the usages of the MOD_* functions.  Get rid of the ones
	  for the file_ops and have the core increment the count of the
	  drivers before the core calls them.
	- please do not use ioctls.  They are hell for 64bit kernels.
	  Use either a filesystem for your subsystem, or sysfs.
	- try doing this for 2.6 first if you want any chance at all to
	  get it into the main kernel trees.

Good luck,

greg k-h
