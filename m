Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262650AbVCSSSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbVCSSSh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 13:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbVCSSSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 13:18:36 -0500
Received: from mailgw1.technion.ac.il ([132.68.238.34]:5293 "EHLO
	mailgw1.technion.ac.il") by vger.kernel.org with ESMTP
	id S262650AbVCSSSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 13:18:34 -0500
Date: Sat, 19 Mar 2005 20:18:24 +0200 (IST)
From: Jacques Goldberg <goldberg@phep2.technion.ac.il>
X-X-Sender: goldberg@localhost.localdomain
Reply-To: Jacques Goldberg <Jacques.Goldberg@cern.ch>
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Need break driver<-->pci-device automatic association
In-Reply-To: <003c01c52bc8$59774750$294b82ce@stuartm>
Message-ID: <Pine.LNX.4.58_heb2.09.0503191949430.11358@localhost.localdomain>
References: <003c01c52bc8$59774750$294b82ce@stuartm>
X-MailKey: 829.36.63
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   Stuart,
   Many thanks for this interesting approach.
   A huge advantage is that it can be implemented as a script.
   But:
   -it still requires the Linux newcomer who wants his modem to work, to
recompile her/his kernel - something which frightens beginners.
   -it implies that when adding a serial device such as an other modem, or
a  serial scanner, the kernel ought again to be recompiled according to
the new hardware configuration.
   -and at each kernel upgrade, often automatic in large organizations,
the kernel must again be tailored to the configuration.

                                         Thanks again - Jacques

On Fri, 18 Mar 2005, Stuart MacDonald wrote:

> From: Jacques Goldberg
> > To be ugly or to never be up to date, that's the question.
> > We did patch 8250_pci.c but there is no way to build a
> > stable list of
> > the devices to be handled that way.
> > We will thus spend some time on the hot unplug solution.
>
> I think what you want might be accomplished if the serial driver was
> compiled as a module. Then have your driver grab all the PCI devices
> it wants, and they shouldn't be grabbed by the serial driver when it
> loads. If you can't get your driver to load before the serial driver
> for whatever reason, unloading the serial driver should give up the
> devices it had claimed.
>
> ..Stu
>
