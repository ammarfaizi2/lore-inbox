Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265473AbSKACli>; Thu, 31 Oct 2002 21:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266243AbSKACli>; Thu, 31 Oct 2002 21:41:38 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:8196 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265473AbSKAClh>;
	Thu, 31 Oct 2002 21:41:37 -0500
Date: Thu, 31 Oct 2002 18:45:04 -0800
From: Greg KH <greg@kroah.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "KOCHI, Takayoshi" <t-kouchi@mvf.biglobe.ne.jp>,
       "Lee, Jung-Ik" <jung-ik.lee@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: bare pci configuration access functions ?
Message-ID: <20021101024504.GC13031@kroah.com>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A495@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A495@orsmsx119.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 06:07:31PM -0800, Grover, Andrew wrote:
> > From: Greg KH [mailto:greg@kroah.com] 
> > Nice, thanks for pointing that out.  But what about the fact that I
> > think we can now start optimizing certain parts of the "generic"
> > code to play nicer with Linux?
> 
> It is much much more important that ACPI be *correct* than fast or small.

I agree.  I was just thinking that ACPI was correct already, and we
could move on toward making it fast and small.  Sorry for thinking that
:)

> I'm used to ACPI ranting from all quarters, you know that ;-) but let me
> just say this:
> 
> - ACPI is not performance-critical
> - ACPI will never be simple and elegant, even if you made it Linux-specific
> - Portability enhances correctness and maximizes developer productivity
> - Read my lips, no new taxes!
> 
> (dunno where that last one came from ;-)

You already said 3 other lies, so a fourth one rounded them all out?  :)

(sorry, couldn't help myself.  For the readers in the peanut gallery,
 I consider Andy a friend, this was not a personal attack, just a chance
 to make a joke.)

To address the above:

> - ACPI is not performance-critical

But it can't hurt in both stack size, and execution speed to fix obvious
things that cause it to slow down.  And if ACPI is too slow, booting
takes longer, and getting ACPI events to other places start taking
unacceptable amounts of times.  Not that this is happening right now :)

> - ACPI will never be simple and elegant, even if you made it Linux-specific

Heh, you said it, I didn't.

> - Portability enhances correctness and maximizes developer productivity

Only if the developers are being forced to work on multiple platforms.
For the majority of Linux kernel developers, luckily we do not have to
do this.  For your group, I understand the constraints, and am willing
to live with it, in order to get a working ACPI implementation.  Beggars
can't be choosy :)

thanks,

greg k-h
