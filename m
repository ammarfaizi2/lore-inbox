Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbTJYLqM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 07:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbTJYLqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 07:46:12 -0400
Received: from as6-4-8.rny.s.bonet.se ([217.215.27.171]:55568 "EHLO
	pc2.dolda2000.com") by vger.kernel.org with ESMTP id S262575AbTJYLqL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 07:46:11 -0400
From: Fredrik Tolf <fredrik@dolda2000.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16282.25212.456947.292339@pc7.dolda2000.com>
Date: Sat, 25 Oct 2003 13:46:04 +0200
To: Mike Anderson <andmike@us.ibm.com>
Cc: Fredrik Tolf <fredrik@dolda2000.com>,
       Patrick Mansfield <patmans@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Elevator bug in concert with usb-storage
In-Reply-To: <20031025062759.GB1288@beaverton.ibm.com>
References: <16279.15393.575929.983297@pc7.dolda2000.com>
	<20031023082726.A20073@beaverton.ibm.com>
	<16280.9893.292564.320412@pc7.dolda2000.com>
	<20031025062759.GB1288@beaverton.ibm.com>
X-Mailer: VM 7.17 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Anderson writes:
 > Fredrik Tolf [fredrik@dolda2000.com] wrote:
 > > Sorry, that didn't work well. It doesn't crash on the same thing
 > > anymore, but nonetheless crashes. In addition, when I have removed the
 > > device but not yet umounted the filesystem, I tried to ls its root
 > > dir. Before, nothing extraordinary happened then, but now there's a
 > > couple of oopses for the ls process as well.
 > >
 > > .. snip ..
 > >
 > > Call Trace:
 > >  [<c02176b3>] elv_queue_empty+0x1d/0x20
 > >  [<c0219ab4>] __make_request+0x80/0x4ae
 > >  [<c021a016>] generic_make_request+0x134/0x186
 > 
 > I tried to reproduce this error last night using the scsi_debug driver,
 > but could not. I tried different combinations of file systems (fat, ext2,
 > ext3). I did notice that I had elevator=deadline on the cmdline. I
 > removed this in case the elevator_queue_empty_fn between the two
 > elevators made a difference. I still was unable to reproduce. I will try
 > a few more combinations of things this weekend and let you know what I
 > find out. There might be a race still with our cleanups and I am not
 > able to reproduce it exactly on my system.

Be aware that this was with usb-storage as the back-end driver. I
don't know if that might make some difference (as opposed to using
scsi_debug, that is).

Is there anything I can do to help?

Fredrik Tolf

