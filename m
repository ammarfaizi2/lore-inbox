Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSHZQEb>; Mon, 26 Aug 2002 12:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316530AbSHZQEb>; Mon, 26 Aug 2002 12:04:31 -0400
Received: from matav-3.matav.hu ([145.236.252.34]:11044 "EHLO
	Milos.fw.matav.hu") by vger.kernel.org with ESMTP
	id <S313558AbSHZQEa>; Mon, 26 Aug 2002 12:04:30 -0400
Date: Mon, 26 Aug 2002 18:00:40 +0200 (CEST)
From: Narancs v1 <narancs@narancs.tii.matav.hu>
X-X-Sender: narancs@helka
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: herbert@debian.org, <srivasta@debian.org>, <aurel32@debian.org>,
       <noodles@earth.li>, <rmayr@debian.org>, <johnf@debian.org>,
       <linux-kernel@vger.kernel.org>
Subject: Where is apa1480_cb gone?
In-Reply-To: <E17hBWU-0001hz-00@localhost>
Message-ID: <Pine.LNX.4.44.0208261755230.32250-100000@helka>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all on linux-kernel!

Is it true that the PCMCIA Cardbus Adaptec SlimSCSI 1480A/B
support is removed from kernel?

how can use such a card?

On Tue, 20 Aug 2002, Aurelien Jarno wrote:

> Le Mardi 20 Août 2002 12:58, vous avez écrit :
> > Hi all!
> >
> > Please help, I have a notebook + Adaptec SlimSCSI 1480A Cardbus
> > PCcard.
> >
> > I have debian sid uptodate
> >
> > If I compile a custom kernel with kernel-package, although the driver
> > is listed in Documentation/Configure.help, I cannot choose it with
> > *config.
> >
> > If I write it in by hand CONFIG_?_APA1480=m, it doesn't compile, and
> > I cannot find the .c source file neither. Nor in 2.4.18.
> >
> > kernel-package 8.007
> > kernel-source-2.4.19-1
> > kernel-patch-freeswan 1.96-1.2
> > kernel-patch-mppe 1.1-1
> > kernel-patch-2.4-grsecurity 1.9.6-1
> > kernel-patch-preempt-2.4 20020620-2
> >
> > Can you help where this driver has gone?
> > maybe some of the patches removes?
> You can try to remove the patches to see if it come from one of them.
> However, I checked in kernel-patch-preempt-2.4, and it doesn't come
> from it.
>
> > maybe it's removed from mainstream?
> It seems it is the answer. On a fresh untared vanilla 2.4.19 kernel,
> there is the option in the documentation, but the .c source doesn't
> exist.
> However looking up in drivers/pci/pci.ids, you can see that the
> APA-1480 and AIC-1480 are the same PCI card. Morever looking in
> drivers/scsi/aic7xxx/aic7xxx_pci.c, there is a function named
> ahc_apa1480_setup.
> I suggest you to try to enable the module "Adaptec AIC7xxx support" in
> "SCSI support ---> SCSI low-level drivers ---> Adaptec AIC7xxx support".
>
> - Aurelien
>

well, I have that module compiled , but when I insert the card it doesn't
load or if I load by hand it doesn't find the card.

any idea?

thanks!

-------------------------
Narancs v1
IT Security Administrator
Warning: This is a really short .sig! Vigyazat: ez egy nagyon rovid szig!


