Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264310AbTLBF67 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 00:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264311AbTLBF67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 00:58:59 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:36618
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264310AbTLBF65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 00:58:57 -0500
Date: Mon, 1 Dec 2003 21:58:52 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Greg Stark <gsstark@mit.edu>, Erik Steffl <steffl@bigfoot.com>,
       linux-kernel@vger.kernel.org
Subject: Re: libata in 2.4.24?
Message-ID: <20031202055852.GP1566@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Greg Stark <gsstark@mit.edu>,
	Erik Steffl <steffl@bigfoot.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0312010836130.13692-100000@logos.cnet> <3FCB8312.3050703@rackable.com> <87fzg4ckej.fsf@stark.dyndns.tv> <3FCBB15F.7050505@rackable.com> <3FCBB9F1.2080300@bigfoot.com> <87n0abbx2k.fsf@stark.dyndns.tv> <20031202055336.GO1566@mis-mike-wstn.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031202055336.GO1566@mis-mike-wstn.matchmail.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 01, 2003 at 09:53:36PM -0800, Mike Fedyk wrote:
> On Tue, Dec 02, 2003 at 12:36:19AM -0500, Greg Stark wrote:
> > 
> > Erik Steffl <steffl@bigfoot.com> writes:
> > 
> > >    not for drives >133GB (I have intel D865PERL mb and 250GB matrox, it doesn't
> > > work without SCSI_ATA (at all), it cannot read/write above 133GB without libata
> > > patches)
> > 
> > My ICH5 was happily using my brand new 200GB SATA maxtor drive, at least up
> > until last Friday when it crashed. Grumble, a brand new drive.
> > 
> > I guess what I'm looking for is the "FAQ" or "README" file that most projects
> > have. What are the advantages of using the libata patch vs the stock drivers
> > and vice versa? What are the differences between the two?
> 
> Libata, uses the scsi system instead of the existing ide layer because many
> new sata controllers are using an interface that is very similair to scsi
> (much like atapi).
> 
> The existing ide layer is geared tward pata (old style with 40 or 80 pins),
> and any sata controller that behaves like a pata coltroller.  That's why
> ICH5 and VIA's controllers are supported first (and not with all of their
> features like hotplug and some others).
> 
> I'd say use the stock ide driver unless libata gives you features you need,
> or a >30% speed boost.
> 
