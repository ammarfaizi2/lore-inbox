Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266055AbUAFA7u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 19:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266058AbUAFA7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 19:59:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:132 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266055AbUAFA7s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 19:59:48 -0500
Date: Tue, 6 Jan 2004 00:59:44 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Daniel Jacobowitz <dan@debian.org>,
       Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040106005944.GH4176@parcelfarce.linux.theplanet.co.uk>
References: <20040104230104.A11439@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <20040105030737.GA29964@nevyn.them.org> <Pine.LNX.4.58.0401041918260.2162@home.osdl.org> <20040105132756.A975@pclin040.win.tue.nl> <Pine.LNX.4.58.0401050749490.21265@home.osdl.org> <20040105205228.A1092@pclin040.win.tue.nl> <Pine.LNX.4.58.0401051224480.2153@home.osdl.org> <20040106001326.A1128@pclin040.win.tue.nl> <Pine.LNX.4.58.0401051522390.5737@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401051522390.5737@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 03:32:03PM -0800, Linus Torvalds wrote:
> 	dev_t lbt_devno()
> 	{
> 		return nr++;
> 	}
> 
> since the numbers do have to be unique "per boot". They just shouldn't be 
> considered "stable" _nor_ "meaningful".

Cute.  There's a little issue of, say it, meaningful relationship between
sda and sda4, completely lost that way.  And _that_ has nothing to do with
device enumeration.
