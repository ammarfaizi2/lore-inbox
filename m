Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288801AbSAJMBd>; Thu, 10 Jan 2002 07:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289412AbSAJMBX>; Thu, 10 Jan 2002 07:01:23 -0500
Received: from khazad-dum.debian.net ([200.196.10.6]:50349 "EHLO
	khazad-dum.debian.net") by vger.kernel.org with ESMTP
	id <S288801AbSAJMBE>; Thu, 10 Jan 2002 07:01:04 -0500
Date: Thu, 10 Jan 2002 10:01:02 -0200
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: linux-kernel@vger.kernel.org, Jani Forssell <jani.forssell@viasys.com>
Subject: Re: Via KT133 pci corruption: stock 2.4.18pre2 oopses as well
Message-ID: <20020110100101.A25366@khazad-dum>
In-Reply-To: <20020109235722.L1200@niksula.cs.hut.fi> <Pine.LNX.4.21.0201100025440.14057-100000@tux.rsn.bth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0201100025440.14057-100000@tux.rsn.bth.se>; from gandalf@wlug.westbo.se on Thu, Jan 10, 2002 at 12:30:37AM +0100
X-GPG-Fingerprint-1: 1024D/128D36EE 50AC 661A 7963 0BBA 8155  43D5 6EF7 F36B 128D 36EE
X-GPG-Fingerprint-2: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
From: hmh@debian.org (Henrique de Moraes Holschuh)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2002, Martin Josefsson wrote:
> We've replaved that memory module now and now it's better but I have to
> say that the KT133 or atleast the Asus A7V motherboard seems to be quite
> broken. we have a lot of spurious irq's and the ide controllers freak when
> but under some load and start getting irq timeouts and resets the ide
> channels over and over again with some delay in between when it kind of
> works, slow as hell but works.

Well, my A7V is also acting up, with spurious IRQs (but not too many), and
PCI lockups if the load on the PCI bus increases too much -- this is
probably the last time I ever buy a VIA board (because they take soooo much
time to acknowledge their screw ups and help people fix it) unless they
start issuing non-binary-only fixes (heck, all it takes is a doc telling us
what to do on the PCI registers!).

The IDE corruption and lockups you can fix, just apply the latest IDE
patches, the 2.4.18pre IDE subsystem is not to be used on a KT133, it will
not work at all if you give it a slightly bigger load on the promise
controller, for example.

> We are going to replace the motherboard with one with VIA KT266A chipset,
> hope that works better.

Without the IDE patches, it will (most probably) not help.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
