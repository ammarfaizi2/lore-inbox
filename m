Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbTE0BQD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 21:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbTE0BOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 21:14:35 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:14540
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262571AbTE0BOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 21:14:22 -0400
Subject: Re: [BK PATCHES] add ata scsi driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0305261306500.12186-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0305261306500.12186-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053995371.17151.37.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 May 2003 01:29:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-05-26 at 21:09, Linus Torvalds wrote:
> My point is that it's _wrong_ to make non-SCSI drivers use the SCSI layer, 
> because that shows that something is misdesigned.

Sure - there is lots of stuff that ought to be generic error
handling/timers/requeue/ioctl stuff that right now happens to be in the
scsi layer, and a megaton of user space that only supports it

> You adding more "pseudo-SCSI" crap just _makes_things_worse. It does not 
> advance anything, it regresses. 

SATA is SCSI with some legacy crap nailed on the back end, next
generation SATA controllers look like scsi, act like scsi, think like
scsi. The bang a register count to ten poke a couple of bits and babysit
the command world of IDE is dying. 

Also with regards to the confusion comment, several vendors now have
identical hardware interfaces for their smart SATA and SCSI devices.
dpt_i2o has an ATA form, aacraid has a SATA form so the confusion 
problem about device names also won't be going away in a hurry.


