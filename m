Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265222AbSKEUo2>; Tue, 5 Nov 2002 15:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265223AbSKEUo2>; Tue, 5 Nov 2002 15:44:28 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:14858 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S265222AbSKEUo1>;
	Tue, 5 Nov 2002 15:44:27 -0500
Date: Tue, 5 Nov 2002 21:51:01 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjanv@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 vi .config ; make oldconfig not working
Message-ID: <20021105205101.GA3014@mars.ravnborg.org>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjanv@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021105165024.GJ13587@suse.de> <3DC7FB11.10209@pobox.com> <20021105171409.GA1137@suse.de> <1036517201.5601.0.camel@localhost.localdomain> <20021105172617.GC1830@suse.de> <1036520436.4791.114.camel@irongate.swansea.linux.org.uk> <20021105181431.GB3515@suse.de> <20021105193004.GA2872@mars.ravnborg.org> <20021105194229.GS2502@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021105194229.GS2502@pasky.ji.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 08:42:29PM +0100, Petr Baudis wrote:
> > The following patch should make most garbage, such as =n, result in
> > # CONFIG_FOO is not set
> > without any user confirmation.
> 
> I don't think this is actually a good idea. We break forward compatibility with
> this (possibly, in future we will want to add something like "yes" or you don't
> know what..), and then you will still get "no" for no obvious reason - asking
> is much saner approach here, IMHO. If we didn't understand it, assuming 'no' is
> not a safe way, I believe.
What actually happens is that any non-recognized value is assumed to be 'n'.
So if 'yes' is recognised, then fine.

And with the simple parser used today "CONFIG_FOO=yes" would be recognised
as yes, because it checks only the 'y'.
I did not look that close on the patch you sent, but I think they
have the same functionality.

If this wasn't after feature freeze I would have liked to see the
hidden .config file to be replaced by for example Kconfigdata or
similar.
So many times I have seen people being asked to backup there
configuration, which is located in a hidden file.
If people should keep their fingers away from it - then we should note
that in the top of the file. As we do in the rest of the kernel.

And then we could have invented a better syntax, that was not
dictated by bash or similar.
Something to propose in the 2.7 timeframe.

	Sam
