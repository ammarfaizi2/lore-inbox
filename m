Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268289AbUHQPG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268289AbUHQPG5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 11:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268285AbUHQPG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 11:06:56 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:60421 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268277AbUHQPG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 11:06:26 -0400
Date: Tue, 17 Aug 2004 16:06:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Markus Lidel <Markus.Lidel@shadowconnect.com>,
       Christoph Hellwig <hch@infradead.org>,
       Warren Togami <wtogami@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Merge I2O patches from -mm
Message-ID: <20040817160621.A22892@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Markus Lidel <Markus.Lidel@shadowconnect.com>,
	Warren Togami <wtogami@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <411F37CC.3020909@redhat.com> <20040817125303.A21238@infradead.org> <412208A6.7020104@shadowconnect.com> <1092751257.22793.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1092751257.22793.8.camel@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Tue, Aug 17, 2004 at 03:00:59PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2004 at 03:00:59PM +0100, Alan Cox wrote:
> On Maw, 2004-08-17 at 14:31, Markus Lidel wrote:
> > > Now to i2o_scsi:
> > >  - the logic of "demand-allocating" Scsi_Hosts looks rather bad to me,
> > >    life would be much simpler with a Scsi_Host per i2o device.
> > 
> > But wouldn't it be a waste of resources to allocate a Scsi_Host 
> > structure for every I2O device? Note that the i2o_scsi "sees" all disks 
> > even if they are in a RAID array, so in most cases there are at least 3 
> > Scsi_Host adapters...
> 
> Christoph the "I2O" device is a communication processor. You need to
> preserve the real scsi busses in order to get sane results from scsi
> tools. If EH is implemented you'll need this to do controlled resets
> (although this gets quite umm 'interesting' if using i2o_block also)

Okay, then we'll have to rething the data structures a little more.
I was under the impression the scsi busses were completely faked for
the OS.

