Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264933AbUD2TpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbUD2TpT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 15:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264943AbUD2TpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 15:45:19 -0400
Received: from mail.kroah.org ([65.200.24.183]:20178 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264933AbUD2TpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 15:45:10 -0400
Date: Thu, 29 Apr 2004 12:44:27 -0700
From: Greg KH <greg@kroah.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: Bryan Small <code_smith@comcast.net>, Sean Young <sean@mess.org>,
       Chester <fitchett@phidgets.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: add new USB PhidgetServo driver
Message-ID: <20040429194426.GA19315@kroah.com>
References: <20040428181806.GA36322@atlantis.8hz.com> <200404292110.21235.oliver@neukum.org> <20040429191605.GB18643@kroah.com> <200404292135.42713.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404292135.42713.oliver@neukum.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 09:35:42PM +0200, Oliver Neukum wrote:
> Am Donnerstag, 29. April 2004 21:16 schrieb Greg KH:
> > On Thu, Apr 29, 2004 at 09:10:21PM +0200, Oliver Neukum wrote:
> > > Am Donnerstag, 29. April 2004 20:49 schrieb Bryan Small:
> > > > The IFkit ( both 8/8/8 and 0/8/8) and the TextLCD will work nearly the
> > > > same as Sean's servo control. They will use sysfs also. They will be
> > >
> > > I don't want to spoil the party, but in which way is using sysfs in this
> > > way different from using it as a form of devfs?
> >
> > 	- one value per file, no char or block nodes
> > 	- devices can export many different files depending on their
> > 	  needs (no ioctl crud needed.)
> > 	- you can use a script or libsysfs a web browser, or anything
> > 	  else that reads directory trees and files to access the device
> > 	  info.
> > 	- you can have as many devices as you want in the system, no
> > 	  limitations on minor numbers, or anything else.
> > 	- no unsolvable kernel race and locking issues
> > 	- no horribly formatted code from a developer who is no longer
> > 	  maintaining it.
> >
> > Shall I go on?  :)
> 
> Yes. You are describing a better devfs, but still devfs. Why not go
> the whole way?

{sigh}  Not again.  Come on Oliver...  Go read the archives for why
Linus does not want us to put device nodes in sysfs.  

Putting device attributes such as led colors, servo motor controls, etc,
look to be much the same idea, are much different from the traditional
block and character nodes we are used to in Unix.

Think of them as mini device specific file systems instead, mounted in a
device tree.

I don't want to discuss this again...

thanks,

greg k-h
