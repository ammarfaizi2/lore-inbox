Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbWG3RIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWG3RIh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 13:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWG3RIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 13:08:37 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32193 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751050AbWG3RIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 13:08:36 -0400
Subject: Re: [patch, rft] ide: reprogram disk pio timings on resume
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jason Lunz <lunz@falooley.org>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, Vojtech Pavlik <vojtech@suse.cz>,
       Brad Campbell <brad@wasp.net.au>, David Brownell <david-b@pacbell.net>
In-Reply-To: <20060729233416.GA6346@opus.vpn-dev.reflex>
References: <200607281646.31207.rjw@sisk.pl>
	 <1154105517.13509.153.camel@localhost.localdomain>
	 <20060729233416.GA6346@opus.vpn-dev.reflex>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 30 Jul 2006 18:26:27 +0100
Message-Id: <1154280387.1615.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-07-29 am 19:34 -0400, ysgrifennodd Jason Lunz:
> driver, but Alan helpfully pointed out that this is the correct thing to
> do globally. Still, I'm only calling hwif->tuneproc() for disks, based
> on two things:
>
>  - The existing state machine is already passed over for non-disk drives

CDs should in theory also need the PIO restore.

Otherwise looks excellent

