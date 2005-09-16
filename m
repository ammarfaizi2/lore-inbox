Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161259AbVIPSpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161259AbVIPSpH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 14:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161261AbVIPSpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 14:45:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:30635 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161259AbVIPSpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 14:45:06 -0400
Date: Fri, 16 Sep 2005 11:44:40 -0700
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dtor_core@ameritech.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, caphrim007@gmail.com,
       David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: Lost keyboard on Inspiron 8200 at 2.6.13
Message-ID: <20050916184440.GA11413@kroah.com>
References: <432A4A1F.3040308@gmail.com> <200509152357.58921.dtor_core@ameritech.net> <20050916025356.0d5189a6.akpm@osdl.org> <d120d500050916082519c660e6@mail.gmail.com> <1126886449.17038.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126886449.17038.4.camel@localhost.localdomain>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 05:00:49PM +0100, Alan Cox wrote:
> On Gwe, 2005-09-16 at 10:25 -0500, Dmitry Torokhov wrote:
> > Interdependencies between ACPI, PNP, USB Legacy emulation and I8042 is
> > very delicate and quite often changes in ACPI/PNP break that balance.
> > USB legacy emulation is just evil. We need to have "usb-handoff" thing
> > enabled by default, it fixes alot of problems.
> 
> I would definitely agree with this. There are very few, if any, cases
> usb handoff doesn't work now that the Nvidia problems are fixed.

Are we sure?  Yeah, SuSE has shipped that code "enabled" for a while,
but I'm still not comfortable making that the default.

Only if we merge the code that does the handoff, with the same code that
does it in the usb core, would I feel more comfortable to enable this
always.  I had a patch from David Brownell to do this, but it had some
link errors at times, so I had to drop it :(

thanks,

greg k-h
