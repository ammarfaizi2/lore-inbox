Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965102AbWBGOfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbWBGOfx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 09:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbWBGOfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 09:35:53 -0500
Received: from host2092.kph.uni-mainz.de ([134.93.134.92]:46499 "EHLO
	a1i15.kph.uni-mainz.de") by vger.kernel.org with ESMTP
	id S965102AbWBGOfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 09:35:52 -0500
From: Ulrich Mueller <ulm@kph.uni-mainz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17384.43328.181493.272871@a1i15.kph.uni-mainz.de>
Date: Tue, 7 Feb 2006 15:05:52 +0100
To: Adrian Bunk <bunk@stusta.de>
Cc: Bernd Petrovitsch <bernd@firmix.at>, Herbert Poetzl <herbert@13thfloor.at>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Arjan van de Ven <arjan@infradead.org>, Mark Lord <lkml@rtr.ca>,
       Ulrich Mueller <ulm@kph.uni-mainz.de>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Byron Stanoszek <gandalf@winds.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: RFC: add an ADVANCED_USER option
References: <uhd7irpi7@a1i15.kph.uni-mainz.de>
	<Pine.LNX.4.61.0602022144190.30391@yvahk01.tjqt.qr>
	<43E3DB99.9020604@rtr.ca>
	<Pine.LNX.4.61.0602041204490.30014@yvahk01.tjqt.qr>
	<1139153913.3131.42.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.61.0602052212430.330@yvahk01.tjqt.qr>
	<1139174355.3131.50.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.61.0602061554550.31522@yvahk01.tjqt.qr>
	<20060207004147.GA21620@MAIL.13thfloor.at>
	<1139305085.13091.17.camel@tara.firmix.at>
	<20060207121955.GD5937@stusta.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 7 Feb 2006, Adrian Bunk wrote:

> What we could do is to add an additional ADVANCED_USER option that
> hides options like VMSPLIT or the NAPI options for net drivers.

> config ADVANCED_USER
> 	bool "ask questions that require a deeper knowledge of the kernel"

> config EXPERIMENTAL
> 	bool "Prompt for development and/or incomplete code/drivers"
> 	depends on ADVANCED_USER

Shouldn't this be the other way around, i.e. ADVANCED_USER depending
on EXPERIMENTAL?

If you implement it as above, people will set ADVANCED_USER to "n" in
oldconfig and then be surprised that all experimental drivers are
gone.
