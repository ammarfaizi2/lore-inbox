Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269174AbRGaEyc>; Tue, 31 Jul 2001 00:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269175AbRGaEyN>; Tue, 31 Jul 2001 00:54:13 -0400
Received: from mail.valinux.com ([198.186.202.175]:18704 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S269174AbRGaEyC>;
	Tue, 31 Jul 2001 00:54:02 -0400
Date: Mon, 30 Jul 2001 21:50:02 -0700
From: Johannes Erdfelt <jerdfelt@valinux.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Andreas Dilger <adilger@turbolinux.com>, Khalid Aziz <khalid@fc.hp.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>,
        greg@kroah.com
Subject: Re: Support for serial console on legacy free machines
Message-ID: <20010730215002.I1275@valinux.com>
In-Reply-To: <200107302240.f6UMeWg2001230@webber.adilger.int> <31754.996543218@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <31754.996543218@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Tue, Jul 31, 2001 at 11:33:38AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 31, 2001, Keith Owens <kaos@ocs.com.au> wrote:
> On Mon, 30 Jul 2001 16:40:31 -0600 (MDT), 
> Andreas Dilger <adilger@turbolinux.com> wrote:
> >What bothers me is that new systems don't have a serial port, and no ISA
> >slots, so there is no hope of getting a "serial console" support without
> >ACPI (which is rather heavyweight AFAIK).  USB is far too complex to use
> >for early-boot debugging, so what else is left?
> 
> I briefly discussed this with the USB maintainers at the 2.5 kernel
> developers conference.  They thought that a stripped down USB serial
> console was possible, without full USB support.  Is that still the
> case?

I think so. Keyboards have a nice feature called boot protocol mode
which is a dumbed down version for BIOS' and the like to use.

What would be needed is a driver for UHCI and OHCI does polling
exclusively, which isn't a big problem and only does control and
interrupt pipes.

I think this can be done with a minimal amount of code. It would
probably be smaller than Linus' original USB driver.

JE

