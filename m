Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268979AbUJKOQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268979AbUJKOQv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 10:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268989AbUJKOQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 10:16:51 -0400
Received: from linaeum.absolutedigital.net ([63.87.232.45]:937 "EHLO
	linaeum.absolutedigital.net") by vger.kernel.org with ESMTP
	id S268979AbUJKOQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:16:34 -0400
Date: Mon, 11 Oct 2004 10:16:25 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Jan Dittmer <j.dittmer@portrix.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       NetDev Mailing List <netdev@oss.sgi.com>, proski@gnu.org,
       hermes@gibson.dropbear.id.au
Subject: Re: [PATCH] Fix readw/writew warnings in drivers/net/wireless/hermes.h
In-Reply-To: <20041011131603.GU23987@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.61.0410111014030.9330@linaeum.absolutedigital.net>
References: <Pine.LNX.4.61.0410110702590.7899@linaeum.absolutedigital.net>
 <416A7484.1030703@portrix.net> <Pine.LNX.4.61.0410110819370.8480@linaeum.absolutedigital.net>
 <20041011131603.GU23987@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:

> On Mon, Oct 11, 2004 at 08:23:35AM -0400, Cal Peake wrote:
> > On Mon, 11 Oct 2004, Jan Dittmer wrote:
> > 
> > > Cal Peake wrote:
> > > 
> > > >  	inw((hw)->iobase + ( (off) << (hw)->reg_spacing )) : \
> > > > -	readw((hw)->iobase + ( (off) << (hw)->reg_spacing )))
> > > > +	readw((void __iomem *)(hw)->iobase + ( (off) << (hw)->reg_spacing )))
> > > >  #define hermes_write_reg(hw, off, val) do { \
> > > 
> > > Isn't the correct fix to declare iobase as (void __iomem *) ?
> > 
> > iobase is an unsigned long, declaring it as a void pointer is prolly not 
> > what we want to do here. The typecast seems proper. A lot of other drivers 
> > do this as well thus it must be proper ;-)
> 
> Typecast is not a proper solution here.   Folks, there are cleanups underway
> for all that mess, but it's not _that_ simple.
> 
> And adding casts to shut the warnings up is wrong in 99% of cases.

ok, I'm retarded. I'll shut up for the moment and get a clue :^)

-- Cal

