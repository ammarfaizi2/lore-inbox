Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265195AbUHMG7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265195AbUHMG7o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 02:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269010AbUHMG7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 02:59:44 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:10982 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265195AbUHMG7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 02:59:42 -0400
Date: Fri, 13 Aug 2004 08:59:03 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@www.pagan.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SG_IO and security
Message-ID: <20040813065902.GB2321@suse.de>
References: <1092313030.21978.34.camel@localhost.localdomain> <Pine.LNX.4.58.0408120929360.1839@ppc970.osdl.org> <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org> <1092341803.22458.37.camel@localhost.localdomain> <Pine.LNX.4.58.0408121705050.1839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408121705050.1839@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12 2004, Linus Torvalds wrote:
> 
> 
> On Thu, 12 Aug 2004, Alan Cox wrote:
> > > > 
> > > > Hmm.. This still allows the old "junk" commands (SCSI_IOCTL_SEND_COMMAND).
> > 
> > That uses sg_io() so gets caught as well unless I screwed up following
> > the code paths.
> 
> No, while the cdrom_ioctl thing does use sg_io, the really old and 
> horrible sg_scsi_ioctl thing does it's own commands by hand.
> 
> I don't know why. I get the feeling that it _should_ use sg_io().

While that does make sense, it would be more code to fold them together
than what is currently there. SCSI_IOCTL_SEND_COMMAND is really
horrible, the person inventing that API should be subject to daily
public ridicule.

-- 
Jens Axboe

