Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbTIZVll (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 17:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbTIZVll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 17:41:41 -0400
Received: from mail.ccur.com ([208.248.32.212]:64775 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S261640AbTIZVlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 17:41:40 -0400
Date: Fri, 26 Sep 2003 17:17:41 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Jim Deas <jdeas@jadsystems.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Prefered method to map PCI memory into userspace.
Message-ID: <20030926211740.GA27352@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <1064609623.16160.11.camel@ArchiveLinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064609623.16160.11.camel@ArchiveLinux>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 26, 2003 at 01:53:43PM -0700, Jim Deas wrote:
> I am looking for the most current (blessed) structure
> for mapping PCI memory to a user process. One that allows
> both PIO and busmastering to work on a common block of
> PCI RAM. I am not concerned with backporting to older
> kernels but it would be nice if the solution wasn't ibm specific.
> 
> My problem is a 64M window into a frame buffer that I would
> like to map into user space. I am more than willing to put
> forth the effort, I just want to make sure I'm heading in
> the right direction.
> 
> Is there a better forum for posting this? Regards,
> J. Deas
> 
> RH9.0 2.4.20-6smp kernel and above.

Albert Cahalan wrote a patch, for 2.6, that makes mmappable all PCI device
memory regions.  They show up as files in the appropriate subdirectories
under /proc/bus/pci.  See http://lkml.org/lkml/2003/7/13/258 for the
patch and details.

Joe
