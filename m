Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266646AbUIORLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266646AbUIORLG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 13:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266821AbUIORJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 13:09:18 -0400
Received: from [69.28.190.101] ([69.28.190.101]:1431 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266878AbUIORHj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 13:07:39 -0400
Date: Wed, 15 Sep 2004 13:07:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Being more anal about iospace accesses..
Message-ID: <20040915170736.GA3394@havoc.gtf.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org> <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org> <20040915165450.GD6158@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040915165450.GD6158@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 06:54:50PM +0200, Jörn Engel wrote:
> On Wed, 15 September 2004 09:30:42 -0700, Linus Torvalds wrote:
> > 
> > For example, if you don't know (or, more importantly - don't care) what 
> > kind of IO interface you use, you can now do something like
> > 
> > 	void __iomem * map = pci_iomap(dev, bar, maxbytes);
> > 	...
> > 	status = ioread32(map + DRIVER_STATUS_OFFSET);
> 
> C now supports pointer arithmetic with void*?  I hope the width of a
> void is not architecture dependent, that would introduce more subtle
> bugs.

gcc extension, which has been used in the kernel for ages.

	Jeff



