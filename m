Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269231AbUIBWDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269231AbUIBWDH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269127AbUIBWCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 18:02:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26788 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269196AbUIBWA3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 18:00:29 -0400
Date: Thu, 2 Sep 2004 23:00:27 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Frank van Maarseveen <frankvm@xs4all.nl>
Cc: Dave Kleikamp <shaggy@austin.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>, Christoph Hellwig <hch@lst.de>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
Message-ID: <20040902220027.GD23987@parcelfarce.linux.theplanet.co.uk>
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain> <20040902203854.GA4801@janus> <1094160994.31499.19.camel@shaggy.austin.ibm.com> <20040902214806.GA5272@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040902214806.GA5272@janus>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 11:48:06PM +0200, Frank van Maarseveen wrote:
> mount is nice for root, clumsy for user. And a rather complicated
> way of accessing data the kernel has knowledge about in the first
> place. For filesystem images, cd'ing into the file is the most
> obvious concept for file-as-a-dir IMHO.

The hell it is.

a) kernel has *NO* *FUCKING* *KNOWLEDGE* of fs type contained on a device.
b) kernel has no way to guess which options to use
c) fs _type_ is a fundamental part of mount - device(s) (if any) involved
are arguments to be interpreted by that particular fs driver.
d) permissions required for that lovely operation (and questions like
whether we force nosuid/noexec, etc.) are nightmare to define.

Frankly, the longer that thread grows, the more obvious it becomes that
file-as-a-dir is a solution in search of problem.  Desperate search, at
that.
