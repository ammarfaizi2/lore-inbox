Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135758AbRDXXnV>; Tue, 24 Apr 2001 19:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135759AbRDXXnB>; Tue, 24 Apr 2001 19:43:01 -0400
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:49934 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S135758AbRDXXmr>; Tue, 24 Apr 2001 19:42:47 -0400
Date: Tue, 24 Apr 2001 19:45:05 -0400
From: Michael Meissner <meissner@spectacle-pond.org>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: Michael Meissner <meissner@spectacle-pond.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3ac13
Message-ID: <20010424194505.B4242@munchkin.spectacle-pond.org>
In-Reply-To: <E14rqT9-0000s4-00@the-village.bc.nu> <20010424193250.A4242@munchkin.spectacle-pond.org> <20010424193642.J6823@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010424193642.J6823@sventech.com>; from johannes@erdfelt.com on Tue, Apr 24, 2001 at 07:36:42PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 07:36:42PM -0400, Johannes Erdfelt wrote:
> On Tue, Apr 24, 2001, Michael Meissner <meissner@spectacle-pond.org> wrote:
> > and it doesn't ask whether I want to build the normal USHI USB driver either as
> > a module or builtin to the kernel, only whether I want to build the alternative
> > USHI USB dirver (the JE driver).  Make xconfig asks whether you want to build
> > both drivers.  I'm not sure whether this was a bug in previous versions or
> > not.
> 
> That's probably because you selected the alternative UHCI driver to
> build into the kernel. In that case, the other UHCI driver is not
> available as an option anymore. If you select it as a module, then both
> will be available.

Ummm, no.

As I said, I first cleaned everything out with mrproper, and then went through
the options in order.  Since the alternative UHCI driver does not occur until
after the question for the normal UHCI driver in drivers/usb/Configure.in, it
never asked me the question of building the normal UHCI driver.  I just
verified that if I use make xconfig instead of make menuconfig, I will be able
to choose either driver (yes, if you choose one as builtin, it won't allow you
to choose the other, but I'm talking about building them as modules, and the
initial selection after make mrproper is done).

-- 
Michael Meissner, Red Hat, Inc.  (GCC group)
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
