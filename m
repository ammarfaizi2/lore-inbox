Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbUCSASB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 19:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263351AbUCRXyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:54:52 -0500
Received: from mail.kroah.org ([65.200.24.183]:58286 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263281AbUCRXsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:48:13 -0500
Date: Thu, 18 Mar 2004 15:21:39 -0800
From: Greg KH <greg@kroah.com>
To: Martin Hicks <mort@wildopensource.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Exporting physical topology information
Message-ID: <20040318232139.GA17586@kroah.com>
References: <20040317213714.GD23195@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040317213714.GD23195@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2004 at 04:37:14PM -0500, Martin Hicks wrote:
> 
> Hi,
> 
> I'm trying to figure out what the best way is to export a minimal amount
> of physical topology information to userland.  Would it be acceptable to
> export this kind of information with sysfs?
> 
> I'm not proposing that we build an entire physical topology tree in
> sysfs, but just providing an attribute file.  The two most obvious
> examples of where this would be useful is for nodes and pci busses.  The
> Altix platform is a modular system with CPU bricks and IO bricks.  We
> currently have no method for locating where "node0" is, nor do we have a
> method for locating pci bus 0000:20, for example.
> 
> If we could physically locate a PCI bus, then it would be much easier
> to (for example) locate our defective SCSI disk that is target4 on the
> SCSI controller that is on pci bus 0000:20.

Um, what's wrong with the current /sys/class/pci_bus/*/cpuaffinity files
for determining this topology information?  That is why it was added.

thanks,

greg k-h
