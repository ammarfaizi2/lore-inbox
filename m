Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262553AbVCaBlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262553AbVCaBlU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 20:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbVCaBlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 20:41:19 -0500
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:21973 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S262553AbVCaBk7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 20:40:59 -0500
X-ORBL: [69.107.61.180]
From: David Brownell <david-b@pacbell.net>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.11, USB: High latency?
Date: Wed, 30 Mar 2005 17:40:49 -0800
User-Agent: KMail/1.7.1
Cc: kus Kusche Klaus <kus@keba.com>, stern@rowland.harvard.edu,
       linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200503301457.35464.david-b@pacbell.net> <200503301728.09969.david-b@pacbell.net> <1112232746.19975.41.camel@mindpipe>
In-Reply-To: <1112232746.19975.41.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503301740.49647.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 March 2005 5:32 pm, Lee Revell wrote:
> On Wed, 2005-03-30 at 17:28 -0800, David Brownell wrote:
> > On Wednesday 30 March 2005 4:51 pm, Lee Revell wrote:
> > > 
> > > This is the exact configuration of one of the users who reported the
> > > problem on LAU.  Got a pointer to the patch?  And what's the issue with
> > > IN transfers?
> > 
> > This is what Greg just posted (and Linus merged into BK, so it'll be
> > in BK snapshots starting tomorrow):
> > 
> >   http://marc.theaimsgroup.com/?l=linux-usb-devel&m=111221966815043&w=2
> > 
> > The issue with IN transfers is that microframe scheduling is ... tricky.
> > ...
> 
> Thanks for the explanation.  I found this patch, and sent the link to
> the LAU posters with the problem.
> 
> There are apparently many users affected (some gave up and went back to
> 2.4), so there's good opportunity for testing.

Yes.  That's why I was particularly glad to see the patches from Karsten;
they were the first ones that actually got "it works for me now!!" reports.

With luck, all full speed ISO-OUT transfers will now work through EHCI.
Even through the funky multi-TT hubs from Cypress.  My main question is
whether this is also true of the TDI (nee ARC) EHCI silicon that's being
embedded in various non-PCI chips.

This all seems off-topic for latency though.  :)

- Dave


> > I'd like to see all that split ISO stuff working with EHCI, but someone
> > else is going to have to do most of the work.  Once it's working we can
> > take the CONFIG_EXPERIMENTAL off, which will remove another source of
> > errors.  :)
> 
> Thanks again for your help, I'll report any interesting results.
> 
> Lee
> 
> 
