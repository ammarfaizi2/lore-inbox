Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263399AbTJUWHk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 18:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263406AbTJUWHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 18:07:39 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:38149 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263399AbTJUWHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 18:07:38 -0400
Subject: Re: 3Com pcmcia wlan with 2.6.0-test8
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Mathias =?ISO-8859-1?Q?Fr=F6hlich?= <Mathias.Froehlich@web.de>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <200310212258.34328.Mathias.Froehlich@web.de>
References: <200310212258.34328.Mathias.Froehlich@web.de>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1066774046.866.70.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-5) 
Date: Wed, 22 Oct 2003 00:07:27 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-21 at 22:58, Mathias Fröhlich wrote:
> I use a 3Com 3CRSHPW196 PCMCIA wlan card with the atmel_cs module on a IBM R40 
> laptop. Installed is Fedora 0.95 together with linux 2.6.0-test8.
> 
> The firmware is loaded using the kernel-hotplug firmware loader.
> 
> When the device is stopped or unloaded i get this message:
> 
> unregister_netdevice: waiting for eth1 to become free. Usage count = 4

I have experienced the same behavior while playing with APM/ACPI
suspend. It seems my machine gets frozen when trying to suspend with
CardBus/USB modules loaded, so I usually unload them before suspending.
Sometimes, I have seen the kernel complaining while unloading 3c59x with
an usage count greater than 1, which is impossible, since I do only have
a network card on my laptop and it's the 3Com.

