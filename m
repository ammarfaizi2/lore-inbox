Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267036AbUBMOoR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 09:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267037AbUBMOoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 09:44:17 -0500
Received: from mail.gmx.de ([213.165.64.20]:57304 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267036AbUBMOoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 09:44:15 -0500
Date: Fri, 13 Feb 2004 15:44:13 +0100 (MET)
From: "Daniel Blueman" <daniel.blueman@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <20040213142719.GA28100@mail.shareable.org>
Subject: Re: File system performance, hardware performance, ext3, 3ware RAID1, etc.
X-Priority: 3 (Normal)
X-Authenticated: #8973862
Message-ID: <17899.1076683453@www11.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is a small loss that the TCQ-support implementation hasn't been stable on
linux so far. I guess mostly due to the great I/O scheduling Linux has (ie
anticipatory scheduler).

Yes, a growing number of IDE disk manufacturers are using native S-ATA
controllers in their disks, and TCQ is one of the core features (ie unique selling
point), as well as being implemented on the more lavish P-ATA controllers.

It's just a shame that there are still issues saturating a bunch of IDE
disks with software RAID in the 2.6 series, but I guess that'll be ironed out in
time...

> Daniel Blueman wrote:
> > many modern IDE disks and
> > controllers also have tagged command queuing, so it is even more of a
> corner case.
> 
> Linux doesn't use tagged command queueing, though - the code has been
> disabled for some time.  I thought the TCQ stuff was disabled because
> only very few disks supported it and the code wasn't reliable.
> 
> Yet you say many modern disks support it?
> 
> -- Jamie
> 

-- 
Daniel J Blueman

GMX ProMail (250 MB Mailbox, 50 FreeSMS, Virenschutz, 2,99 EUR/Monat...)
jetzt 3 Monate GRATIS + 3x DER SPIEGEL +++ http://www.gmx.net/derspiegel +++

