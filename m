Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262222AbULMLJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbULMLJr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 06:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbULMLJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 06:09:47 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:60124 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S262222AbULMLJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 06:09:40 -0500
Date: Mon, 13 Dec 2004 12:08:52 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
Message-ID: <20041213110852.GQ16322@dualathlon.random>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <20041212234256.GK6272@elf.ucw.cz> <cone.1102896588.31702.10669.502@pc.kolivas.org> <20041213104321.GB7340@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213104321.GB7340@elf.ucw.cz>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 11:43:21AM +0100, Pavel Machek wrote:
> Doing lot less per timer tick is not going to help much... You cpu

I also doubt we can do significantly less per timer tick. There's some
new code and lock like the monotonic_lock but that's going to be lost in
the noise, the irq highlevel interface has some overhead too, but that's
going to be lost in the noise too. The rest pretty much cannot be
avoided. I didn't measure it but I suspect the slowest part might
actually be the outb_p/inb_p and the enter/exit kernel.
