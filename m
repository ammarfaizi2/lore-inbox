Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbUCITwo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 14:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbUCITwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 14:52:43 -0500
Received: from pop.gmx.net ([213.165.64.20]:52893 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262107AbUCITwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 14:52:32 -0500
X-Authenticated: #13243522
Message-ID: <404E206A.266ABD1C@gmx.de>
Date: Tue, 09 Mar 2004 20:52:10 +0100
From: Michael Schierl <schierlm@gmx.de>
X-Mailer: Mozilla 4.75 [de]C-CCK-MCD QXW0324v  (Win95; U)
X-Accept-Language: de,en
MIME-Version: 1.0
To: Antony Dovgal <tony2001@phpclub.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: APM & device_power_up/down
References: <1uQOH-4Z1-9@gated-at.bofh.it>
		<S261722AbUCFWoa/20040306224430Z+905@vger.kernel.org> <20040309101110.50b55786.tony2001@phpclub.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antony Dovgal schrieb:
> 
> On Sat, 06 Mar 2004 23:44:08 +0100
> Michael Schierl <schierlm-usenet@gmx.de> wrote:
> 
> > Hmm. Can you try unapplying it and applying the one in
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=107506063605497&w=2
> > instead? Does it work for you as well as with no patch?
> 
> Yes, it works ok for me with this patch.

Are you using any modules or patches that are not in the main line
kernel?
Does your problem also occur when you build a "minimal" kernel (i.e.
remove all things from it you don't really need for booting up, e.g.
local apic, pcmcia, network support, framebuffer, mouse)?

can you boot with init=/bin/bash (or another shell) and then do 

mount /proc
apm -s

does suspending work there? (this all against a "vanilla" kernel).

The thing above was just a guess, the only difference between the 2
patches i know is that the patch which is in kernel also informs all
device drivers. So i guess there must be a "broken" device driver that
makes your supend come to a halt.

Michael
