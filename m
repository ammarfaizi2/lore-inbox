Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWBGCEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWBGCEy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 21:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWBGCEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 21:04:54 -0500
Received: from dialin-159-117.tor.primus.ca ([216.254.159.117]:22472 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S932439AbWBGCEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 21:04:53 -0500
Date: Mon, 6 Feb 2006 21:04:41 -0500
From: William Park <opengeometry@yahoo.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: DMA in PCI chipset -- module vs. compiled-in
Message-ID: <20060207020441.GA3309@node1.opengeometry.net>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
References: <20060206034312.GA2962@node1.opengeometry.net> <1139200372.2791.208.camel@mindpipe> <1139255365.10437.49.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139255365.10437.49.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2006 at 07:49:25PM +0000, Alan Cox wrote:
> On Sul, 2006-02-05 at 23:32 -0500, Lee Revell wrote:
> > Generic and chipset specific support are not complementary, they are
> > mutually exclusive.  Having generic PCI IDE support enabled will prevent
> > the chipset specific support from working properly.
> 
> Untrue.
> 
> The PCI generic driver by default grabs only hardware with PCI IDS it
> knows can be driven generically. That list purposefully has no overlaps
> with chipset drivers.

The kernel I'm using is 2.6.14.  My chipset is Via 82c694x and 82c686b
(Abit VP6 dual-P3 with HighPoint 370).  DMA is on only when 'via82cxxx'
and 'hpt366' are compiled in.  Most importantly, DMA cannot be turned on
if loading by module.

Does it mean that this "bug" is pecular to my chipset?

-- 
William Park <opengeometry@yahoo.ca>, Toronto, Canada
ThinFlash: Linux thin-client on USB key (flash) drive
	   http://home.eol.ca/~parkw/thinflash.html
BashDiff: Super Bash shell
	  http://freshmeat.net/projects/bashdiff/
