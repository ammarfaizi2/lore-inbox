Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265837AbUGDX1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265837AbUGDX1Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 19:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265840AbUGDX1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 19:27:24 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:51986 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S265837AbUGDX1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 19:27:23 -0400
Date: Mon, 5 Jul 2004 01:27:16 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, David Balazic <david.balazic@hermes.si>
Subject: Re: Weird:  30 sec delay during early boot
Message-ID: <20040704232716.GA18403@pclin040.win.tue.nl>
References: <40E83F53.3050006@pobox.com> <Pine.LNX.4.44.0407041536040.19105-100000@humbolt.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0407041536040.19105-100000@humbolt.us.dell.com>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : kweetal.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2004 at 03:52:51PM -0500, Matt Domsch wrote:

> Only that it's now probing more than just the first disk, but the
> first 16 possible BIOS disks.  If the BIOS behaves badly to an int13
> READ_SECTORS command, that'd be good to know...

I recall text fragments like

 "Any device claiming compliance to ATA-3 or later as indicated in
  IDENTIFY DEVICE or IDENTIFY PACKET DEVICE data should properly
  release PDIAG- after a power-on or hardware reset upon receiving
  the first command or after 31 seconds have elapsed since the reset,
  whichever comes first."

that seem to imply that probing a nonexistent device may take 31 sec
before one is allowed to conclude that there is nothing there.

Andries


(ide_wait_hwif_ready() used to wait 35 seconds)

