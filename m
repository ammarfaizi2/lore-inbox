Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbVKWQeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbVKWQeg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVKWQeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:34:36 -0500
Received: from styx.suse.cz ([82.119.242.94]:38848 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751251AbVKWQed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:34:33 -0500
Date: Wed, 23 Nov 2005 17:34:32 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: Marc Koschewski <marc@osknowledge.org>, Jon Smirl <jonsmirl@gmail.com>,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Christmas list for the kernel
Message-ID: <20051123163432.GC2434@ucw.cz>
References: <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com> <20051123121726.GA7328@ucw.cz> <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com> <20051123150349.GA15449@flint.arm.linux.org.uk> <9e4733910511230719h67fa96bdxdeb654aa12f18e67@mail.gmail.com> <20051123160231.GC6970@stiffy.osknowledge.org> <20051123161637.GI15449@flint.arm.linux.org.uk> <20051123162337.GA2434@ucw.cz> <20051123162728.GJ15449@flint.arm.linux.org.uk> <d120d5000511230831g7e552c87n8431c461c063d29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000511230831g7e552c87n8431c461c063d29@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 11:31:30AM -0500, Dmitry Torokhov wrote:
> On 11/23/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > On Wed, Nov 23, 2005 at 05:23:37PM +0100, Vojtech Pavlik wrote:
> > > On Wed, Nov 23, 2005 at 04:16:37PM +0000, Russell King wrote:
> > > > It means that we spun in the serial interrupt for more than 256 times
> > > > and reached the limit on the amount of work we were prepared to do.
> > > > Any idea what you were doing when these happened?
> > >
> > > Because ACPI was right and the second serial port isn't there?
> >
> > Well, it certainly looked like a serial port when it was probed - to the
> > extent that even loopback mode worked.  Hence I'd be very surprised if
> > it wasn't there.
> >
> 
> It could be on board but not having a connector attached. SInce it is
> not useable ACPI might omit it.
 
Still, even with noise on the RX line, the ISR should be able to empty
the RX FIFO faster than it fills itself, and not result in "too much
work".

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
