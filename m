Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319551AbSH3LrN>; Fri, 30 Aug 2002 07:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319553AbSH3LrN>; Fri, 30 Aug 2002 07:47:13 -0400
Received: from kim.it.uu.se ([130.238.12.178]:3237 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S319551AbSH3LrM>;
	Fri, 30 Aug 2002 07:47:12 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15727.23612.577930.303318@kim.it.uu.se>
Date: Fri, 30 Aug 2002 13:51:24 +0200
To: Moritz Muehlenhoff <jmm@Informatik.Uni-Bremen.DE>
Cc: Padraig Brady <padraig.brady@corvil.com>, linux-kernel@vger.kernel.org
Subject: Re: Keyboard freezes on SIS630 based Clevo notebooks
In-Reply-To: <200208300926.g7U9Qa305884@x06.informatik.uni-bremen.de>
References: <20020829190533.GA11223@informatik.uni-bremen.de>
	<3D6F34AE.7040603@corvil.com>
	<200208300926.g7U9Qa305884@x06.informatik.uni-bremen.de>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moritz Muehlenhoff writes:
 > In stuga.ml.linux.kernel, you wrote:
 > >> I own a SIS630 based notebook from Baycom (model name "Worldbook II"), which
 > >> indeed is a rebrand from a Clevo/Kapok model (normal model name 2700C).
 > >> 
 > >> I'm experiencing occasional, unreproducable keyboard lockups.
 > > 
 > > Me too (2700).
 > > 
 > > If noticed the lockups occur when the "battery low"
 > > light starts flashing. I.E. it's realted to some
 > > APM event. Also the mouse is unresponsive for me
 > > when this happens.
 > 
 > There were some lockups when I connected the AC plug, but these
 > were rare and totally irreproducable as well.
 > Alan had the same idea as you and gave me the hint to rebuild
 > the kernel without APM and APIC.

Some laptops, including the Dell Inspiron ones, (a) don't tell the
kernel APM when they're about to do APM stuff, and (b) have a buggy
APM and/or SMM implementation that breaks if the kernel has enabled
the local APIC. The workaround is to not enable the local APIC. If
this fixes your machine, please post your machine's DMI strings so
we can update the local APIC blacklist rule set in dmi_scan.

Events that would break the Dells include pulling or inserting the
AC plug, and hitting the magic key combo to enter the BIOS screens.

/Mikael
