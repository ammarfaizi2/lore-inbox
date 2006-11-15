Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966640AbWKOEFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966640AbWKOEFh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 23:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966573AbWKOEFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 23:05:37 -0500
Received: from gate.crashing.org ([63.228.1.57]:41856 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S966667AbWKOEFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 23:05:36 -0500
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>
In-Reply-To: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
References: <200611150059.kAF0xBTl009796@hera.kernel.org>
	 <455A6EBF.7060200@garzik.org>
	 <Pine.LNX.4.64.0611141747490.3349@woody.osdl.org>
	 <455A7E21.7020701@garzik.org>
	 <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
Content-Type: text/plain
Date: Wed, 15 Nov 2006 15:04:51 +1100
Message-Id: <1163563491.5940.209.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I don't think "nice" is enough of an advantage to overcome "doesn't work 
> on God knows how many systems".

Note that the PCIe spec mandates MSIs while old style interrults (LSIs)
are optional... The result is that there are already platforms (though
not x86 just yet) being design with simply no support for LSIs on PCIe
and I've heard of devices doing that too (yeah, that's weird, they
wouldn't work in windows I suppose).

I suppose none of this affects x86 for now... For ppc, once we get our
new MSI layer in, however, I'll have to keep them enabled by default,
though there are fewer platforms involved and the chances at this point
are fairly high that they all use a working chipset.
  
Ben.


