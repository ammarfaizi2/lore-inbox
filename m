Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264555AbTKNRn5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 12:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264577AbTKNRn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 12:43:57 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:26372
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264555AbTKNRn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 12:43:27 -0500
Date: Fri, 14 Nov 2003 09:43:26 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Bernd Schubert <bernd-schubert@web.de>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, linux-kernel@vger.kernel.org
Subject: Re: 2 TB partition support
Message-ID: <20031114174326.GK2014@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Bernd Schubert <bernd-schubert@web.de>,
	Peter Chubb <peter@chubb.wattle.id.au>,
	linux-kernel@vger.kernel.org
References: <16304.9647.994684.804486@wombat.chubb.wattle.id.au> <20031112002811.GA18177@tc.pci.uni-heidelberg.de> <16306.35684.471324.582862@wombat.chubb.wattle.id.au> <200311141814.26887.bernd-schubert@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311141814.26887.bernd-schubert@web.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 14, 2003 at 06:14:26PM +0100, Bernd Schubert wrote:
> > On unpatched 2.4, the limit (depending on your driver) for a single
> > block device is either 2TB-1k or 1TB - 512b.
> >
> > The 2.4 kernel keeps the block device sizes in an unsigned int, in 1k
> > units, so the maximum size is (2^32-1)*1k.
> >
> > I forget which subsystem does it,but one of them tries to keep the
> > capacity of a disc in an unsigned int in 512byte units; if you're using
> > that subsystem, the macimum size you can use is (2^31-1)*512b
> >
> 
> Hello Peter,
> 
>  thanks for your help. Which driver doest this 2TB or 1TB-maximum blocksize 
> size depend on? 

The hardware driver, ide or scsi subsystem, and the VFS all interact to
make the limitations on this.

It'd probably be best to post what kind of disk controllers you have, and
see what your limitations will be for them without the patch.  And even with
the patch, many of the hardware drivers may have lurking bugs for larger
block dev sizes.
