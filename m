Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbTKQUwW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 15:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbTKQUwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 15:52:22 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:26048 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261733AbTKQUwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 15:52:17 -0500
Date: Mon, 17 Nov 2003 15:40:39 -0500
From: Andrew Pimlott <andrew@pimlott.net>
To: Maciej Zenczykowski <maze@cela.pl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_CRC32 in 2.4.22 breaks PCMCIA
Message-ID: <20031117204039.GB12931@pimlott.net>
Mail-Followup-To: Maciej Zenczykowski <maze@cela.pl>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20031117200451.GA12931@pimlott.net> <Pine.LNX.4.44.0311172121400.3939-100000@gaia.cela.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311172121400.3939-100000@gaia.cela.pl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 09:23:31PM +0100, Maciej Zenczykowski wrote:
> > CONFIG_CRC32 was introduced in 2.4.22.  I found that if I didn't
> > explicitly set it, the pcnet_cs driver from stand-alone PCMCIA
> > distribution didn't work.  PCMCIA relies on the crc functions, and
> > since they were always available before 2.4.22, it doesn't check for
> > them.
> 
> Something wrong with the in-kernel pcnet_cs?

No, something is wrong with in-kernel ray_cs.  :-(  Oops posted a
few weeks ago.

    http://groups.google.com/groups?selm=fa.gevojmd.732qbh%40ifi.uio.no

> > This seems to be significant breakage, and it took me a good while
> > to figure out what was going on.  Is this change reasonable in the
> > stable kernel series?
> 
> Well, it's in the help for the CRC32 option that it's available to enable 
> external-kernel tree drivers to access these functions.  If you are 
> running make oldconfig you'll hit the question and if you don't know what 
> it's about you should consult help...

I think I used xconfig the first time I configured this kernel
(because I coincidentally wanted to change something).  It was a
while ago, and I only tried pcnet_cs today, so my memory isn't
perfect.  Maybe I should have used oldconfig first, but I doubt
everyone else does that for stable kernels.

It still seems unwise to change the default in a stable kernel.  Let
the people who want it set CONFIG_OMIT_CRC32 or something.

Andrew
