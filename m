Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287244AbSACM5b>; Thu, 3 Jan 2002 07:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287248AbSACM5V>; Thu, 3 Jan 2002 07:57:21 -0500
Received: from fungus.teststation.com ([212.32.186.211]:42500 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S287244AbSACM5D>; Thu, 3 Jan 2002 07:57:03 -0500
Date: Thu, 3 Jan 2002 13:56:27 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <esr@thyrsus.com>, David Woodhouse <dwmw2@infradead.org>,
        Dave Jones <davej@suse.de>, Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <E16M6qn-00088Y-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0201031321470.26000-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Alan Cox wrote:

> > So you're saying the users should be completely lost any time they want
> > to use an upated kernel?
> 
> Quite honestly if you want a user built "update" kernel it should probably
> work out the critical stuff (CPU, memory size limit, SMP) set a few things
> to safe values, and build all the driver modules.

If the previous config is saved automatically that could be used and do an
oldconfig as the autoconfig.

  kbuild 2.5 has /lib/modules/`uname -r`/.config ?
  the old idea of appending config.gz to the kernel image
  /etc/defkernel.config
  ...

If this is for people doing updates I can't imagine anything better than
using the existing config as a base. Even if the config is a vendor config
and they are now building a non-vendor kernel.

That would help people from turning off things they (think they) don't
need but that their init scripts assume is there. Things you can't
autodetect.

The first step from vendor kernel to a custom one will mean that a few
options are no longer vaild, but that shouldn't be a problem for
oldconfig.


Or perhaps do both, get the old config as base, then autodetect the
hardware you can find. Any new options are set to on or off based on the
detected hardware. After that you let the user turn things on and off.

If the user tries to turn off something that you know he has in the box
give a big warning ("Are you sure you want to disable IDE? I can see that
you have both an IDE HD and CD-ROM. This behaviour is inconsistent with
logic." :)

All of this is of course for the "Aunt Tilly" mode only.
(make tillyconfig? :)

/Urban

