Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWB0LpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWB0LpH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 06:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWB0LpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 06:45:07 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37539 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750940AbWB0LpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 06:45:05 -0500
Subject: Re: Kernel SeekCompleteErrors... Different from Re: LibPATA code
	issues / 2.6.15.4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Lord <liml@rtr.ca>
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>,
       James Courtier-Dutton <James@superbug.co.uk>,
       David Greaves <david@dgreaves.com>,
       Justin Piszcz <jpiszcz@lucidpixels.com>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, htejun@gmail.com
In-Reply-To: <44021141.6000601@rtr.ca>
References: <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca>
	 <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca>
	 <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca>
	 <44019E96.20804@superbug.co.uk> <4401B378.3030005@rtr.ca>
	 <4401BB85.7070407@superbug.co.uk> <4401DF6B.9010409@rtr.ca>
	 <20060226171307.GA9682@gallifrey>
	 <1140975791.27539.19.camel@localhost.localdomain> <44021141.6000601@rtr.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Feb 2006 11:48:08 +0000
Message-Id: <1141040889.27539.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2006-02-26 at 15:36 -0500, Mark Lord wrote:
> It still is unreliable, as being discussed in another thread.
> 
> libata wrongly says "medium error" any time it issues a command
> that the drive rejects (unsupported, invalid parameters, etc..).

It seems to still get a single case wrong. But it does the report the
ATA state correctly still.

> This is biting a few people in 2.6.16-rc*, due to the FUA stuff.

It is driven by a table in 

libata-scsi.c:ata_to_sense_error()

so if you can figure out the wrong entry and tweak the table that would
be great

