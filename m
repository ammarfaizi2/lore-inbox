Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281845AbRKRXow>; Sun, 18 Nov 2001 18:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281822AbRKRXol>; Sun, 18 Nov 2001 18:44:41 -0500
Received: from mail100.mail.bellsouth.net ([205.152.58.40]:40491 "EHLO
	imf00bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281470AbRKRXo2>; Sun, 18 Nov 2001 18:44:28 -0500
Message-ID: <3BF847D1.54532522@mandrakesoft.com>
Date: Sun, 18 Nov 2001 18:44:17 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Faux Pas III <fauxpas@temp123.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Weird PCMCIA behavior
In-Reply-To: <20011118180656.A18252@temp123.org> <3BF84297.7FB77B3B@mandrakesoft.com> <20011118182903.A18291@temp123.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Faux Pas III wrote:
> 
> On Sun, Nov 18, 2001 at 06:21:59PM -0500, Jeff Garzik wrote:
> 
> > pcmcia-cs problems are reported to http://pcmcia-cs.sourceforge.net/
> > We encourage you to use the kernel's cardbus code instead :)
> > (CONFIG_PCMCIA and CONFIG_CARDBUS)
> 
> That's what I'm using to get these errors.  I think, although I haven't
> fully tested yet, that pcmcia-cs's core works fine in all power states.
> 
> > As a side note, with kernel cardbus support, you should no longer need
> > external utilities or external drivers.  It should Just Work(tm).
> 
> Do I not still need the cardmgr and all that rot from pcmcia-cs ?  That's
> what I've been using for detection, bind cards to specific modules, etc.

Nope.  CardBus looks like hotplug PCI to the kernel, so all normal PCI
drivers automagically work as CardBus drivers.  You actually need no
userspace tools at all..

Also note there is a kernel cardbus PM fix in the latest 2.4.15-preXX
patches...

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

