Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWDUXje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWDUXje (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 19:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWDUXje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 19:39:34 -0400
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:14767 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750769AbWDUXjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 19:39:33 -0400
To: Hugh Dickins <hugh@veritas.com>
Cc: Pavel Machek <pavel@suse.cz>, Arkadiusz Miskiewicz <arekm@maven.pl>,
       Jeff Chua <jeffchua@silk.corp.fedex.com>, Jeff Garzik <jeff@garzik.org>,
       Matt Mackall <mpm@selenic.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sata suspend resume ...
References: <Pine.LNX.4.64.0604192324040.29606@indiana.corp.fedex.com>
	<Pine.LNX.4.64.0604191659230.7660@blonde.wat.veritas.com>
	<20060420134713.GA2360@ucw.cz>
	<Pine.LNX.4.64.0604211333050.4891@blonde.wat.veritas.com>
	<20060421163930.GA1648@elf.ucw.cz>
	<Pine.LNX.4.64.0604212108010.7531@blonde.wat.veritas.com>
From: Chris Ball <cjb@mrao.cam.ac.uk>
Date: Sat, 22 Apr 2006 00:39:25 +0100
In-Reply-To: <Pine.LNX.4.64.0604212108010.7531@blonde.wat.veritas.com> (Hugh
 Dickins's message of "Fri, 21 Apr 2006 21:44:59 +0100 (BST)")
Message-ID: <yd3bquuqz0y.fsf@islay.ra.phy.cam.ac.uk>
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.4 (Social Property,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> On Fri, 21 Apr 2006, Hugh Dickins <hugh@veritas.com> said:

   > But you've made me try a bit harder, and the patch below, waiting
   > for ATA_BUSY to clear, copying a line used in several other places
   > there, fixes it in a much more satisfactory way than mdelay(2000).
   > (I checked how long it in fact was waiting, saw various waits
   > between 0.8s and 1.3s).

FWIW, this patch fixes S3 resume for me too.  I'm on an Alienware m5500
using sd_mod and ata_piix, and I think your T43p is using AHCI, so it
seems that this fixes a libata-wide problem rather than something 
specific to your hardware.

- Chris.
-- 
Chris Ball   <cjb@mrao.cam.ac.uk>    <http://blog.printf.net/>

