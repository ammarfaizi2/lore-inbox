Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266666AbUHIQRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266666AbUHIQRW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 12:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266705AbUHIQRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 12:17:21 -0400
Received: from vivaldi.madbase.net ([81.173.6.10]:38377 "HELO
	vivaldi.madbase.net") by vger.kernel.org with SMTP id S266684AbUHIQRM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 12:17:12 -0400
Date: Mon, 9 Aug 2004 12:17:10 -0400 (EDT)
From: Eric Lammerts <eric@lammerts.org>
X-X-Sender: eric@vivaldi.madbase.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Marc Ballarin <Ballarin.Marc@gmx.de>, Greg KH <greg@kroah.com>,
       albert@users.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dynamic /dev security hole?
In-Reply-To: <1092062974.14153.26.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0408091203160.8353@vivaldi.madbase.net>
References: <20040808162115.GA7597@kroah.com>  <1091969260.5759.125.camel@cube>
  <20040808175834.59758fc0.Ballarin.Marc@gmx.de>  <20040808162115.GA7597@kroah.com>
  <20040809000727.1eaf917b.Ballarin.Marc@gmx.de> 
 <Pine.LNX.4.58.0408090025590.26834@vivaldi.madbase.net>
 <1092062974.14153.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Aug 2004, Alan Cox wrote:
> On Llu, 2004-08-09 at 05:40, Eric Lammerts wrote:
> > Just an idea for a fix for this problem: If udev would change the
> > permissions to 000 and ownership to root.root just before it unlinks
> > the device node, the copy would become useless.
>
> Unfortunately not the whole story. The permissions are checked at open
> time not on read/write/ioctl so once I have the device opened you
> lose.

It's only meant as a fix for the hardlink trick, not against the open
file descriptor trick. About the latter, if someone still has the
device opened, how can it go away? And if it doesn't go away, how can
udev create a new node with the same major/minor?

Eric
