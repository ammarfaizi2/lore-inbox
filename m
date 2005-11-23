Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbVKWQXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbVKWQXk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVKWQXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:23:40 -0500
Received: from styx.suse.cz ([82.119.242.94]:20926 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751026AbVKWQXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:23:39 -0500
Date: Wed, 23 Nov 2005 17:23:37 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Marc Koschewski <marc@osknowledge.org>, Jon Smirl <jonsmirl@gmail.com>,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Christmas list for the kernel
Message-ID: <20051123162337.GA2434@ucw.cz>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com> <20051122204918.GA5299@kroah.com> <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com> <20051123121726.GA7328@ucw.cz> <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com> <20051123150349.GA15449@flint.arm.linux.org.uk> <9e4733910511230719h67fa96bdxdeb654aa12f18e67@mail.gmail.com> <20051123160231.GC6970@stiffy.osknowledge.org> <20051123161637.GI15449@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123161637.GI15449@flint.arm.linux.org.uk>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 04:16:37PM +0000, Russell King wrote:
> On Wed, Nov 23, 2005 at 05:02:33PM +0100, Marc Koschewski wrote:
> > Mine looks like this.
> > 
> > * Why is the seconf line for ttyS1 missing (as you have one above)?
> 
> Probably because whatever-added-ttyS0 didn't add ttyS1 as well.  As
> I've said, due to the complex initialisation of serial (and the fact
> I don't see this) I can't provide a more useful answer.
> 
> At a guess, the "whatever-added-ttyS0" could be ACPI.  ACPI doesn't
> have the notion of devices, so any ACPI ports would appear as legacy
> devices.  Hence, ttyS0 may have been provided by both the legacy table
> and maybe ACPI, whereas ttyS1 seems to only be provided by the legacy
> table.
> 
> Maybe that indicates your ACPI is buggy.  I don't know.  I know nothing
> about ACPI.
> 
> > * What does these 'too much work' messages mean? Must have been come
> >   in lately...
> 
> It means that we spun in the serial interrupt for more than 256 times
> and reached the limit on the amount of work we were prepared to do.
> Any idea what you were doing when these happened?
 
Because ACPI was right and the second serial port isn't there?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
