Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVCYTEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVCYTEq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 14:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbVCYTEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 14:04:46 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:30886 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261229AbVCYTEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 14:04:44 -0500
Subject: Re: megaraid driver (proposed patch)
From: James Bottomley <jejb@steeleye.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Bruno Cornec <Bruno.Cornec@hp.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, tvignaud@mandrakesoft.com
In-Reply-To: <20050325184718.GA15215@infradead.org>
References: <20050325182252.GA4268@morley.grenoble.hp.com>
	 <1111775992.5692.25.camel@mulgrave>  <20050325184718.GA15215@infradead.org>
Content-Type: text/plain
Date: Fri, 25 Mar 2005 13:04:37 -0600
Message-Id: <1111777477.5692.29.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-25 at 18:47 +0000, Christoph Hellwig wrote:
> On Fri, Mar 25, 2005 at 12:39:52PM -0600, James Bottomley wrote:
> > On Fri, 2005-03-25 at 19:22 +0100, Bruno Cornec wrote:
> > > Would you consider to apply the following patch proposed by Thierry
> > > Vignaud as a solution for the MandrakeSoft kernel in the mainstream 2.6 
> > > kernel ?
> > 
> > Well, to be considered you'd need to cc the megaraid maintainers and the
> > linux-scsi mailing list.
> > 
> > > -if MEGARAID_NEWGEN=n
> > 
> > No, this is wrong it would break allyes configs and I'd get shot.
> 
> Why?  The megaraid drivers shouldn't have any conflicting non-static
> symbols

You get a kernel with two drivers trying to claim some of the same set
of cards.  The winner will be the driver that gets its init routines
called first, but this isn't a desirable outcome.

I wouldn't object to a patch that allows both *modules* to be built,
which is all I think the distros are after.

James


