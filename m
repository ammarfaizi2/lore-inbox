Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbTE0GRV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 02:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTE0GRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 02:17:21 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43282 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262676AbTE0GRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 02:17:20 -0400
Date: Mon, 26 May 2003 23:30:12 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] add ata scsi driver
In-Reply-To: <3ED300A8.4000405@pobox.com>
Message-ID: <Pine.LNX.4.44.0305262314260.18484-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 May 2003, Jeff Garzik wrote:
> 
> As you see from Alan's message and others, it isn't pseudo-SCSI.

It _is_ pseudo-scsi.

Or rather, what used to be SCSI is quickly becoming irrelevant. There's 
almost nothing left, except for the command set. And SCSI is a lot more 
than the command set, it's the full definition of the signalling from 
command set to electricals to connectors.

And the other stuff matters. The linux SCSI layer proper is full of the
_addressing_ that is part of the SCSI standard proper, and that is pretty
much total nonsense outside of that standard (it's starting to be nonsense 
even inside that standard, since everybody running away fron the old buses 
and the old addressing).

So we shouldn't call it SCSI, because it clearly IS NOT, whatever you
claim. This is a _fact_, I don't see why you argue against it. SCSI has a
well-defined definition (or rather, a _set_ of definitions), and SATA
ain't there. One is T10, the other is part of T13. 

And quite frankly, names matter, and calling it SCSI is clearly wrong.  
What makes you _think_ it is SCSI is that everybody uses the command set,
and all devices are starting to largely just talk MMC-2+.

But calling it MMC-2 is also incorrect, since everybody really talks a
superset, and we should just accept that and not try to limit outselves.

		Linus

