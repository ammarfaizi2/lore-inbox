Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWBSMFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWBSMFI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 07:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWBSMFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 07:05:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:22315 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932405AbWBSMFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 07:05:06 -0500
Date: Sun, 19 Feb 2006 13:04:46 +0100
From: Jens Axboe <axboe@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Martin Michlmayr <tbm@cyrius.com>,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060219120446.GD8852@suse.de>
References: <Pine.LNX.4.64.0602122256130.6773@iabervon.org> <20060213062158.GA2335@kroah.com> <Pine.LNX.4.64.0602130244500.6773@iabervon.org> <20060213175142.GB20952@kroah.com> <d120d5000602131003l7bd1451bs64076475fdd6079c@mail.gmail.com> <Pine.LNX.4.64.0602131339140.6773@iabervon.org> <43F641A2.50200@tmr.com> <20060218120617.GA911@infradead.org> <20060218133715.GA8422@unjust.cyrius.com> <20060218135224.GA2904@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218135224.GA2904@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18 2006, Christoph Hellwig wrote:
> On Sat, Feb 18, 2006 at 01:37:15PM +0000, Martin Michlmayr wrote:
> > * Christoph Hellwig <hch@infradead.org> [2006-02-18 12:06]:
> > > > It would be nice to have one place to go to find burners, and to have
> > > > the model information in that place.
> > > /proc/sys/dev/cdrom/info
> > 
> > Nice.  Is that a stable interface people can rely on (seems this me it
> > should rather be in sys)?  I maintain a tool in Debian to rip/encode
> > audio CDs with one command and we could use this file to find the CD
> > interface if it's not specified by the user.
> 
> I think it's pretty stable.  Except for adding new capabilities it's been
> unchanged since the 2.2.x days.
> 
> Maybe Jens can comment more on it?

Yeah it's stable, new entries have been added at the end if necessary. I
don't necessarily think it's a super way to find these things out,
sometimes older SCSI drives fail some of the mode sense / capability
probing and don't show correct values. So one could do better in user
space.

But at least it's a generic way to see which devices have been
registered as CDROM's, if that is the goal.

-- 
Jens Axboe

