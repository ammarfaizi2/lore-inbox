Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267851AbUG3VNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267851AbUG3VNK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 17:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267850AbUG3VNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 17:13:09 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:57543 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267847AbUG3VM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 17:12:59 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: Exposing ROM's though sysfs
Date: Fri, 30 Jul 2004 14:12:30 -0700
User-Agent: KMail/1.6.2
Cc: Jon Smirl <jonsmirl@yahoo.com>, Martin Mares <mj@ucw.cz>,
       Matthew Wilcox <willy@debian.org>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20040730210755.23849.qmail@web14921.mail.yahoo.com>
In-Reply-To: <20040730210755.23849.qmail@web14921.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407301412.30155.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, July 30, 2004 2:07 pm, Jon Smirl wrote:
> --- Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> > We can get away without caching a copy of the ROM in the kernel if we
> > require
> > userspace to cache it before the driver takes control of the card
> > (i.e. at
> > POST time).  Otherwise, the kernel will have to take care of it.
>
> You may also need ROM access when resuming a suspended device so we
> need to plan for that case too.

The kernel will need it?  Or userspace will need it to resume the card?  If 
the latter, then it should be possible to have userspace cache it the first 
time it's read or something, to be on the safe side for video cards.

Jesse
