Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264948AbUD2TiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264948AbUD2TiO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 15:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbUD2Tgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 15:36:47 -0400
Received: from mail1.kontent.de ([81.88.34.36]:57233 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264939AbUD2Tfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 15:35:47 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] USB: add new USB PhidgetServo driver
Date: Thu, 29 Apr 2004 21:35:42 +0200
User-Agent: KMail/1.5.1
Cc: Bryan Small <code_smith@comcast.net>, Sean Young <sean@mess.org>,
       Chester <fitchett@phidgets.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20040428181806.GA36322@atlantis.8hz.com> <200404292110.21235.oliver@neukum.org> <20040429191605.GB18643@kroah.com>
In-Reply-To: <20040429191605.GB18643@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404292135.42713.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 29. April 2004 21:16 schrieb Greg KH:
> On Thu, Apr 29, 2004 at 09:10:21PM +0200, Oliver Neukum wrote:
> > Am Donnerstag, 29. April 2004 20:49 schrieb Bryan Small:
> > > The IFkit ( both 8/8/8 and 0/8/8) and the TextLCD will work nearly the
> > > same as Sean's servo control. They will use sysfs also. They will be
> >
> > I don't want to spoil the party, but in which way is using sysfs in this
> > way different from using it as a form of devfs?
>
> 	- one value per file, no char or block nodes
> 	- devices can export many different files depending on their
> 	  needs (no ioctl crud needed.)
> 	- you can use a script or libsysfs a web browser, or anything
> 	  else that reads directory trees and files to access the device
> 	  info.
> 	- you can have as many devices as you want in the system, no
> 	  limitations on minor numbers, or anything else.
> 	- no unsolvable kernel race and locking issues
> 	- no horribly formatted code from a developer who is no longer
> 	  maintaining it.
>
> Shall I go on?  :)

Yes. You are describing a better devfs, but still devfs. Why not go
the whole way?

	Regards
		Oliver


