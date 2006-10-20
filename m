Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946483AbWJTUvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946483AbWJTUvU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 16:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946486AbWJTUvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 16:51:20 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37536 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1946483AbWJTUvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 16:51:19 -0400
Subject: Re: Linux 2.6.19-rc2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kevin Radloff <radsaq@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3b0ffc1f0610201130i8f15e49oec2cdc68abb8dbd@mail.gmail.com>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
	 <3b0ffc1f0610201130i8f15e49oec2cdc68abb8dbd@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 20 Oct 2006 21:53:06 +0100
Message-Id: <1161377586.26440.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-10-20 am 14:30 -0400, ysgrifennodd Kevin Radloff:
> On 10/13/06, Linus Torvalds <torvalds@osdl.org> wrote:
> > Ok, it's a week since -rc1, so -rc2 is out there.
> 
> A bit behind, but booting still takes ages on my laptop as
> libata/ata_piix tries to probe a device that isn't there (I reported
> this previously against -rc1, but got no response):

Probing is somewhat broken in 2.6.18 - something in the core code
changed as its upset quite a few drivers at once. One case causes
repeated errors and finally detection of an ATAPI device, the other
causes repeated errors and then failure when no device is present but
takes a few minutes and keeps IRQs locked off for long periods. Both
appear to be fallouts from the new EH code.

Alan

