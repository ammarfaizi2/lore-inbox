Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262607AbVFWQ0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262607AbVFWQ0p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 12:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbVFWQ0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 12:26:45 -0400
Received: from colin.muc.de ([193.149.48.1]:41988 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262607AbVFWQYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 12:24:49 -0400
Date: 23 Jun 2005 18:24:48 +0200
Date: Thu, 23 Jun 2005 18:24:48 +0200
From: Andi Kleen <ak@muc.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@suse.cz>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] Add removal schedule of register_serial/unregister_serial to appropriate file
Message-ID: <20050623162448.GA5430@muc.de>
References: <20050623142335.A5564@flint.arm.linux.org.uk> <20050623140316.GH3749@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050623140316.GH3749@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 04:03:16PM +0200, Adrian Bunk wrote:
> On Thu, Jun 23, 2005 at 02:23:35PM +0100, Russell King wrote:
> >...
> > However, wouldn't it be a good idea if this file was ordered by "when" ?
> > A quick scan of the file reveals a couple of overdue/forgotten items
> > (maybe they happened but the entry in the file got missed?):
> >...
> > What:   register_ioctl32_conversion() / unregister_ioctl32_conversion()
> > When:   April 2005
> >...
> 
> The removal (including the removal of the feature-removal-schedule.txt 
> entry) is already in -mm.

Ok, but I hope whoever did that fixed the locking in the compat
path too. e.g. the BKL is not needed anymore.

-Andi
