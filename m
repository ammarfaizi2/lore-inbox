Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267529AbUHEBAD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267529AbUHEBAD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 21:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267530AbUHEBAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 21:00:03 -0400
Received: from avalon.servus.at ([193.170.194.18]:10373 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S267529AbUHEA77
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 20:59:59 -0400
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.enemy.org>
Message-Id: <200408050056.i750ujfQ010136@wildsau.enemy.org>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
In-Reply-To: <20040804125818.GM10340@suse.de>
To: Jens Axboe <axboe@suse.de>
Date: Thu, 5 Aug 2004 02:56:45 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org, schilling@fokus.fraunhofer.de
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Aug 04 2004, Jens Axboe wrote:
> > > + * Sat Jun 12 12:48:12 CEST 2004 herp - Herbert Rosmanith
> > > + *     Force ATAPI driver if dev= starts with /dev/hd and device
> > > + *     is present in /proc/ide/hdX
> > > + *
> > 
> > That's an extremely bad idea, you want to force ATA driver in either
> > case.
> 
> Which, happily, is what already happens and why it works fine when you

okay - my last email in this matter to LKML, but: it seems to only work
fine if you use ide-scsi and configure it acordingly. on our system, where
I have disabled scsi completely (ide-scsi doesnt work at all for certain
tasks, and beside from that, I need scsi), cdrecord/cdrtools will terminate with
"Cannot open /dev/hdX. Cannot open SCSI driver".

this is the reason why the patch forces the ata (atapi?) driver. no
SCSI driver or configuring of ide-scsi required.

> just do -dev=/dev/hdX. What should be removed is the warning that
> cdrecord spits out when you do this, and the whole ATAPI thing should
> just mirror ATA and scsi-linux-ata be killed completely.
> 
> So I suggest you do that instead and send it to Joerg, cdrecord/cdrtool

well, sigh .... been there, done that, but emails to Joerg seem to have
a long RTT. therefore, LKML. sorry for the inconvenience :->

bye,
herp
