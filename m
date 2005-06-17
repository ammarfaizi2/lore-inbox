Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262033AbVFQRs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbVFQRs5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 13:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbVFQRs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 13:48:56 -0400
Received: from CPE000f6690d4e4-CM00003965a061.cpe.net.cable.rogers.com ([69.193.74.134]:59663
	"EHLO tentacle.dhs.org") by vger.kernel.org with ESMTP
	id S262033AbVFQRsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 13:48:51 -0400
Date: Fri, 17 Jun 2005 13:56:05 -0400
To: Arnd Bergmann <arnd@arndb.de>
Cc: Robert Love <rml@novell.com>, Zach Brown <zab@zabbo.net>,
       linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] inotify.
Message-ID: <20050617175605.GB1981@tentacle.dhs.org>
References: <1118855899.3949.21.camel@betsy> <42B1BC4B.3010804@zabbo.net> <1118946334.3949.63.camel@betsy> <200506171907.39940.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506171907.39940.arnd@arndb.de>
User-Agent: Mutt/1.5.9i
From: John McCutchan <ttb@tentacle.dhs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2005 at 07:07:38PM +0200, Arnd Bergmann wrote:
> On Dunnersdag 16 Juni 2005 20:25, Robert Love wrote:
> > +Q: Why a device node?
> > +
> > +A: The second biggest problem with dnotify is that the user
> > +interface sucks ass. ?Signals are a terrible, terrible interface
> > +for file notification. ?Or for anything, for that matter. ?The
> > +idea solution, from all perspectives, is a file descriptor based
> > +one that allows basic file I/O and poll/select. ?Obtaining the
> > +fd and managing the watches could of been done either via a
> > +device file or a family of new system calls. ?We decided to
> > +implement a device file because adding three or four new system
> > +calls that mirrored open, close, and ioctl seemed silly. ?A
> > +character device makes sense from user-space and was easy to
> > +implement inside of the kernel.
> 
> Sorry to bring up a topic that should have been settled a long time ago.
> 

This was settled a long time ago. Robert, Andrew, and I had an off-list
discussion months ago, and we all agreed that this was the right
interface for inotify.

John
