Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270332AbTG1Q6W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 12:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270345AbTG1Q6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 12:58:22 -0400
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:64151
	"EHLO xanadu.home") by vger.kernel.org with ESMTP id S270332AbTG1Q6T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 12:58:19 -0400
Date: Mon, 28 Jul 2003 13:13:12 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Christoph Hellwig <hch@infradead.org>
cc: Bernardo Innocenti <bernie@develer.com>, Willy Tarreau <willy@w.ods.org>,
       Christoph Hellwig <hch@lst.de>,
       uClinux development list <uclinux-dev@uclinux.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [uClinux-dev] Kernel 2.6 size increase
In-Reply-To: <20030725164649.A6557@infradead.org>
Message-ID: <Pine.LNX.4.44.0307281307480.6507-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jul 2003, Christoph Hellwig wrote:

> On Thu, Jul 24, 2003 at 10:27:16PM +0200, Bernardo Innocenti wrote:
> > Some of the bigger 2.6 additions cannot be configured out.
> > I wish sysfs and the different I/O schedulers could be removed.
> 
> Removing the I/O schedulers is pretty trivial, please come up with a
> patch to make both of them optional and maybe add a trivial noop one.
> 
> Removing sysfs should also be pretty trivial but I'm not sure whether
> you really want that.

Being able to remove the block layer entirely, just as for the networking
layer, should be considered too, since none of ramfs, tmpfs, nfs, smbfs,
jffs and jffs2 just to name those ones actually need the block layer to
operate.  This is really a big pile of dead code in many embedded setups.


Nicolas

