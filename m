Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVCNAis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVCNAis (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 19:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVCNAir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 19:38:47 -0500
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:11427 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261608AbVCNAig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 19:38:36 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16948.56612.119258.653782@wombat.chubb.wattle.id.au>
Date: Mon, 14 Mar 2005 11:39:00 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Peter Chubb <peterc@gelato.unsw.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: User mode drivers: part 1, interrupt handling (patch for 2.6.11)
In-Reply-To: <9e473391050312082777a02001@mail.gmail.com>
References: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU>
	<20050311102920.GB30252@elf.ucw.cz>
	<9e473391050312082777a02001@mail.gmail.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jon" == Jon Smirl <jonsmirl@gmail.com> writes:

Jon> On Fri, 11 Mar 2005 11:29:20 +0100, Pavel Machek <pavel@ucw.cz>
Jon> wrote:
>> Hi!
>> 
>> > As many of you will be aware, we've been working on
>> infrastructure for > user-mode PCI and other drivers.  The first
>> step is to be able to > handle interrupts from user
>> space. Subsequent patches add > infrastructure for setting up DMA
>> for PCI devices.
>> >
>> > The user-level interrupt code doesn't depend on the other
>> patches, and > is probably the most mature of this patchset.
>> 
>> Okay, I like it; it means way easier PCI driver development.

Jon> It won't help with PCI driver development. I tried implementing
Jon> this for UML. If your driver has any bugs it won't get the
Jon> interrupts acknowledged correctly and you'll end up rebooting.

That's not actually true, at least when we developed drivers here.
The only times we had to reboot were the times we mucked up the dma
register settings, and dma'd all over the kernel by mistake...

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
