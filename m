Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278683AbRJSWXU>; Fri, 19 Oct 2001 18:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278685AbRJSWXK>; Fri, 19 Oct 2001 18:23:10 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:47085 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S278683AbRJSWWz>; Fri, 19 Oct 2001 18:22:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Mike Fedyk <mfedyk@matchmail.com>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Sat, 20 Oct 2001 00:25:33 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.33.0110191108590.17647-100000@osdlab.pdx.osdl.net> <15uft5-12MXk8C@fmrl04.sul.t-online.com> <20011019132418.I2467@mikef-linux.matchmail.com>
In-Reply-To: <20011019132418.I2467@mikef-linux.matchmail.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <15ui2Y-05aCZcC@fmrl05.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 October 2001 22:24, you wrote:
> > You could encode that device id in the node's path or use the path as a
> > moniker for the device id (the symlink solution does this), but you need
> > to have more information about the device than it's minor number (the X
> > in /dev/lpX).
> What does devfs do now?

Gets the name from the device driver, usually X is the minor number (or the 
minor number + some constant, if several drivers share a major number). The 
names are only constant if the devices are discovered in the same order.


> > Ok, but I think no one doubts that it is a bad idea to assign ethX
> > semi-randomly. Basically this is the same problem as with device files,
> > only in a different namespace.
> So is that in favor of changing the current ethX naming convention or not?

I don't know. You don't need a device file for networking, but if there is 
some mechanism to allow stable names it would certainly be good to use it for 
network, too. 


> > The device registry (www.tjansen.de/devreg) patches devfs to allow the
> > things described above though.
> Everything, with all of the ids?  What about scsi/ide?

Only SCSI/sd, PCI and USB.

bye...

