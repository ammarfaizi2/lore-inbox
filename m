Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVARNan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVARNan (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 08:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVARNan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 08:30:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31412 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261295AbVARNah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 08:30:37 -0500
Date: Tue, 18 Jan 2005 08:20:15 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>, linux-kernel@vger.kernel.org
Subject: Re: 2.4: "access beyond end of device" after ext2 mount
Message-ID: <20050118102014.GC25979@logos.cnet>
References: <20050115233530.GA2803@darkside.22.kls.lan> <20050117194635.GD22202@logos.cnet> <20050118105547.GD8747@pclin040.win.tue.nl> <20050118084526.GB25979@logos.cnet> <20050118123708.GE8747@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118123708.GE8747@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 01:37:08PM +0100, Andries Brouwer wrote:
> On Tue, Jan 18, 2005 at 06:45:26AM -0200, Marcelo Tosatti wrote:
> 
> > > I suppose that what happens is the following:
> > > mounting sets the blocksize to 4096.
> > > After reading 9992360 sectors, reading the next block means reading
> > > the next 8 sectors and that fails because only 6 sectors are left.
> > 
> > So this is either not a Linux error and not a disk error, its just that the
> > "use with filesystem" then "direct access" is a unfortunate combination.
> 
> It is not a disk error, but I consider it a Linux error.

OK.

> > What would be the correct fix for this for this, if any?
> 
> For 2.4 my reaction would be to say that it is a known property
> of the system, possibly less fortunate, an unimportant flaw.

This seems to be harmless, so, better do nothing about it.

> Of course a fix is possible if this is deemed important for some reason.
> 
> > v2.6 should suffer from the same issues?
> 
> I don't think so. But 2.6 details are rather different.

OK!
