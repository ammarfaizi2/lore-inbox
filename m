Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263756AbUDMVWY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 17:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263763AbUDMVWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 17:22:24 -0400
Received: from 80-218-57-148.dclient.hispeed.ch ([80.218.57.148]:64517 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S263756AbUDMVWS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 17:22:18 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Jin Suh <jinssuh@yahoo.com>
Subject: Re: [2.4.25] PCMCIA PCI: No IRQ for interrupt pin A and failed to allocate shared interrupt
Date: Tue, 13 Apr 2004 23:17:16 +0200
User-Agent: KMail/1.5.2
References: <20040413200634.88036.qmail@web41210.mail.yahoo.com>
In-Reply-To: <20040413200634.88036.qmail@web41210.mail.yahoo.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404132317.16242.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the problem seems to be very simple: yenta can't get an interrupt 'cos another
driver has the same interrupt line exclusivley. it's the pc110pad driver.
deactivate it under
	Character devices  --->
		Mice  --->
			<n> PC110 digitizer pad support
and yenta get's it's interrupt back :)
it's a driver for the digitizer pad on the IBM PC110 palmtop. i don't think
you need it.

your cardbus firewire card will work too, since it shares the interrupt line with
the cardbus bridge.

rgds
-daniel

