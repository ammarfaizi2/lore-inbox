Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262937AbSJDR6q>; Fri, 4 Oct 2002 13:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262960AbSJDR6q>; Fri, 4 Oct 2002 13:58:46 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:22799 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262937AbSJDR6p>;
	Fri, 4 Oct 2002 13:58:45 -0400
Date: Fri, 4 Oct 2002 11:01:21 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] pcibios_* removals for 2.5.40
Message-ID: <20021004180120.GA7576@kroah.com>
References: <1033750426.31839.45.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.33.0210041023060.1917-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0210041023060.1917-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 10:30:41AM -0700, Linus Torvalds wrote:
> 
> On 4 Oct 2002, Alan Cox wrote:
> > 
> > Ermm Greg fixed the drivers using it too.
> 
> Ehhmm... The patch description says "remove pci_find_device()", which is 
> used all over the map and isn't even deprecated (even though it probably 
> should be, and people should just register their drivers correctly).

Argh, that's a typo.  It should say:
	"remove pcibios_find_device()"
as that's what I did.

That function has been depreciated for some time.  I did look into
trying to get rid of pci_find_device() but that's just too much work to
do right now (and there are a few places in the kernel that seem to
really need to use that function, as there's no other way to do some
fixups.)

So yes, removing pci_find_device() should be a 2.7 thing, not a 2.5
thing.

thanks,

greg k-h
