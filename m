Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264974AbTFETid (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 15:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265082AbTFETic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 15:38:32 -0400
Received: from ns.suse.de ([213.95.15.193]:60688 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264974AbTFETi2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 15:38:28 -0400
Date: Thu, 5 Jun 2003 21:51:58 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, warren@togami.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-rc7 AMD64 dpt_i2o fails compile
Message-ID: <20030605195158.GB4725@wotan.suse.de>
References: <1054789161.3699.67.camel@laptop.suse.lists.linux.kernel> <20030605010841.A29837@devserv.devel.redhat.com.suse.lists.linux.kernel> <1054799692.3699.77.camel@laptop.suse.lists.linux.kernel> <1054808477.15276.0.camel@dhcp22.swansea.linux.org.uk.suse.lists.linux.kernel> <p73wug067qb.fsf@oldwotan.suse.de> <1054842344.15457.43.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054842344.15457.43.camel@dhcp22.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 08:45:44PM +0100, Alan Cox wrote:
> On Iau, 2003-06-05 at 13:15, Andi Kleen wrote:
> > Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > 
> > > Fixing up dpt_i2o for the new DMA stuff is a major job. Fixing it for
> > > 64bit cleanness even more so.
> > 
> > If the hardware/firmware supports 64bit pointers then at least AMD64
> > can work without the PCI DMA API. 
> 
> 32bit all around as far I as I can tell

Then fixing it to use the DMA code is best - you can use 32bit pointers
fine then. Just the code in the driver itself needs to be able to tolerate
a 64bit host.

-Andi
