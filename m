Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275010AbTHRUrc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 16:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275022AbTHRUrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 16:47:32 -0400
Received: from mail.kroah.org ([65.200.24.183]:9602 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S275010AbTHRUrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 16:47:22 -0400
Date: Mon, 18 Aug 2003 13:47:43 -0700
From: Greg KH <greg@kroah.com>
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: Does sysfs really provides persistent hardware path to devices?
Message-ID: <20030818204743.GA3245@kroah.com>
References: <200307262036.13989.arvidjaar@mail.ru> <200307282044.43131.arvidjaar@mail.ru> <20030728170308.GA4839@kroah.com> <200308172041.31874.arvidjaar@mail.ru> <20030817182847.GA2422@kroah.com> <20030818020425.GB10453@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030818020425.GB10453@pegasys.ws>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 17, 2003 at 07:04:25PM -0700, jw schultz wrote:
> 
> <OT>
> That's nice.  Now add a second camera from the same vendor
> :(

Then don't use that rule :)

> No, i don't expect you to be able to uniquely identify
> identical devices being added and removed from a single USB buss
> in a persistent way.

If there is _no_ unique way to identify the device, that that is
impossible.

> But it would be nice if we could get consistency between busses so
> that a mouse on one USB buss weren't confused with a mouse on another
> USB buss.

We already have that today, it's called /dev/mice :)

Seriously, I support topology positions, that solves this problem for
real.

> > Does that help?  Have you looked at the 2003 OLS paper about udev for
> > more information?
> 
> Actually you have not answered his question.  And i think it
> a reasonable one.  It could be it was answered elsewhere.

I don't think I really understand the question.  Given a specific
question, I think I could.

> >>>> Question: how to configure udev so that "database" always refers to LUN 0
> >>>> on target 0 on bus 0 on HBA in PCI slot 1.
> >> Let's avoid this communication problem. You show me namedev.config line that 
> >> implements the above.
> 
> I'll try to put slightly differently.  I'll concede that we
> cannot positionaly identify USB devices so lets set that
> aside for the nonce.

Um, you can, see the topology stuff.

> We can persistently, positionaly
> identify a device within the HBA context (BUS +ID + LUN) and
> should be able to do the same for a PCI HBA (PCI slot +
> device) or (PCI bridge topology).

Yup, that works too.

> So can i uniquely identify using persistent positional
> information a drive at PCI_slot=1, HBA_on_card=0, BUS=0,
> ID=1, LUN=0?

Use that position as a topology/name indicator.

> And how do i uniquely identify it in the udev
> config file so that adding the same model drive in the same
> BUS+ID+LUN on an same model HBA card in another PCI slot
> does not confuse the two?

Again, use the topology position.

Please, go read the paper and look at sysfs before asking anything
else...

thanks,

greg k-h
