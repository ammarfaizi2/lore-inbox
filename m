Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268272AbUH2S5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268272AbUH2S5w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 14:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268273AbUH2S5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 14:57:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64984 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268272AbUH2S5t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 14:57:49 -0400
Date: Sun, 29 Aug 2004 19:57:44 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Hans Reiser <reiser@namesys.com>
Cc: flx@msu.ru, Paul Jackson <pj@sgi.com>, riel@redhat.com, ninja@slaphack.com,
       torvalds@osdl.org, diegocg@teleline.es, jamie@shareable.org,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, jra@samba.org, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040829185744.GQ21964@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0408271043090.10272-100000@chimarrao.boston.redhat.com> <412F7D63.4000109@namesys.com> <20040827230857.69340aec.pj@sgi.com> <20040829150231.GE9471@alias> <4132205A.9080505@namesys.com> <20040829183629.GP21964@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040829183629.GP21964@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2004 at 07:36:29PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > he wants without recompiling to do it.  This kind of a view requires no 
> > coding because you can just mount the root filesystem two ways, one with 
> > the -nopseudos mount option, and one without it.
> 
> *What*?
> 
> OK, now I want detailed explanation of the reasons why that doesn't create
> cache coherency problems.
> 
> Do you have an analysis of locking in the entire thing?

And I am very, very serious about that - we are talking about very nasty
minefield and design choices in that area have fundamental impact on the
entire layer, wherever it is located.

It's *NOT* something that you can leave until later and hope it somehow
falls into place - it can be merged in steps, but you MUST know the goal
on that level.  To rearchitect later might be possible (even though you
will a hell of a time avoiding plugins breakage), but it will be *hard*.
