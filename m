Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264632AbTEPXtX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 19:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264634AbTEPXtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 19:49:23 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:48809 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264632AbTEPXtU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 19:49:20 -0400
Date: Fri, 16 May 2003 17:03:38 -0700
From: Greg KH <greg@kroah.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: Manuel Estrada Sainz <ranty@debian.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>
Subject: Re: request_firmware() hotplug interface, third round.
Message-ID: <20030517000338.GA17466@kroah.com>
References: <20030515200324.GB12949@ranty.ddts.net> <20030516223624.GA16759@kroah.com> <200305170155.15295.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305170155.15295.oliver@neukum.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 17, 2003 at 01:55:15AM +0200, Oliver Neukum wrote:
> 
> > > 	- echo 1 > /sysfs/class/firmware/dev_name/loading
> > > 	- cat whatever_fw > /sysfs/class/firmware/dev_name/data
> > > 	- echo 0 > /sysfs/class/firmware/dev_name/loading
> >
> > Nice, but can't you get rid of the loading file by just relying on
> > open() and close()?  Oh wait, sysfs doesn't pass that down to you, hm,
> > looks like you need that info.  But does the new binary interface in
> > sysfs that just got merged into the tree provide that info for you?
> 
> But what if the close() is due to irregular termination?
> If the script is killed, do you download half a firmware?

Good point.  Actually I don't think that the binary interface for sysfs
passes open and close down to the lower levels, so it's a moot point.

echo... works for me.

thanks,

greg k-h
