Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVARMh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVARMh0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 07:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVARMhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 07:37:25 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:31494 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261281AbVARMhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 07:37:10 -0500
Date: Tue, 18 Jan 2005 13:37:08 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4: "access beyond end of device" after ext2 mount
Message-ID: <20050118123708.GE8747@pclin040.win.tue.nl>
References: <20050115233530.GA2803@darkside.22.kls.lan> <20050117194635.GD22202@logos.cnet> <20050118105547.GD8747@pclin040.win.tue.nl> <20050118084526.GB25979@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118084526.GB25979@logos.cnet>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 06:45:26AM -0200, Marcelo Tosatti wrote:

> > I suppose that what happens is the following:
> > mounting sets the blocksize to 4096.
> > After reading 9992360 sectors, reading the next block means reading
> > the next 8 sectors and that fails because only 6 sectors are left.
> 
> So this is either not a Linux error and not a disk error, its just that the
> "use with filesystem" then "direct access" is a unfortunate combination.

It is not a disk error, but I consider it a Linux error.

> What would be the correct fix for this for this, if any?

For 2.4 my reaction would be to say that it is a known property
of the system, possibly less fortunate, an unimportant flaw.
Of course a fix is possible if this is deemed important for some reason.

> v2.6 should suffer from the same issues?

I don't think so. But 2.6 details are rather different.

Andries
