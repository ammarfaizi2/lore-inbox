Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261698AbSJHW2b>; Tue, 8 Oct 2002 18:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261644AbSJHW1t>; Tue, 8 Oct 2002 18:27:49 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:34825 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261698AbSJHW1W>;
	Tue, 8 Oct 2002 18:27:22 -0400
Date: Tue, 8 Oct 2002 15:29:18 -0700
From: Greg KH <greg@kroah.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Patrick Mochel <mochel@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, andre@linux-ide.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] embedded struct device Re: [patch] IDE driver model update
Message-ID: <20021008222917.GA10837@kroah.com>
References: <Pine.LNX.4.44.0210081425430.1457-100000@home.transmeta.com> <Pine.GSO.4.21.0210081735370.5897-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0210081735370.5897-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 05:42:25PM -0400, Alexander Viro wrote:
> 
> _IF_ the last two steps were done by ->release(), your arguments would
> work.  Actually they are done by driver right after the put_device() call.

Yes, and that's wrong :(

> If you are willing to change that (== move all destruction into ->release()) -
> yeah, then embedded struct device will work.  It's a hell of a work though.

It's not that much work, and I'll do it for USB, and for PCI, unless Pat
beats me to it.

thanks,

greg k-h
