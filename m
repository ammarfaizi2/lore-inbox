Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbVK2Vrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbVK2Vrc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 16:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbVK2Vrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 16:47:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16550 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932426AbVK2Vrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 16:47:31 -0500
Date: Tue, 29 Nov 2005 13:47:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Linux 2.6.15-rc3
In-Reply-To: <20051129213656.GA8706@aitel.hist.no>
Message-ID: <Pine.LNX.4.64.0511291340340.3029@g5.osdl.org>
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org>
 <20051129213656.GA8706@aitel.hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 29 Nov 2005, Helge Hafting wrote:
> 
> Can't open root dev "831" or unknown block(8,49)
> Please append a correct root= boot option
> unable to mount root fs from block(8,49)

Sounds like your SATA drive wasn't detected.

Please double-check that your config changes didn't disable it, but 
otherwise:

> Now 2.6.14 works with exactly the same lilo.con,
> where I have root=/dev/sdd1  (SATA drive)

please specify _which_ SATA driver you are using so that Jeff & co can try 
to figure out what broke since 2.6.14.

Also, if you can pinpoint where it broke better, that probably helps 
(most sata changes were in -rc1, but there were some sata_mv and sata_sil4 
changes in in -rc2 too, so even just poinpointing it to either of those 
will help, although the daily builds might be even better).

			Linus
