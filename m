Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVBNMew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVBNMew (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 07:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVBNMew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 07:34:52 -0500
Received: from pop.gmx.de ([213.165.64.20]:50644 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261424AbVBNMeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 07:34:50 -0500
X-Authenticated: #8956447
Subject: Re: [Problem] slow write to dvd-ram since 2.6.7-bk8
From: Droebbel <droebbel.melta@gmx.de>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20050214105332.GA7163@dose.home.local>
References: <1108301794.9280.18.camel@localhost.localdomain>
	 <20050213142635.GA2035@animx.eu.org>
	 <20050214085320.GA4910@dose.home.local>
	 <1108376734.9495.8.camel@localhost.localdomain>
	 <20050214105332.GA7163@dose.home.local>
Content-Type: text/plain
Date: Mon, 14 Feb 2005 13:34:48 +0100
Message-Id: <1108384488.9495.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.5 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 2005-02-14 at 11:53 +0100, Tino Keitel wrote:
>On Mon, Feb 14, 2005 at 11:25:34 +0100, Droebbel wrote:
>> Which 2.6.7 did you use? 
>
>Only 2.6.7 with a -mm patch, since vanilla 2.6.7 screwed up my system
>clock, and the noapic option which was suggested to unscrew the clock
>screwed up the USB driver etc... :-(

Which -mm patch? If that patch contains the error, the bk8 contains it 
as well and the bk7 doesn't, that might already make serching a bit
easier. Or maybe 2.6.6, if you want a stable release. Not tested yet.

>What kernels do you suggest me to test?
You might try the last working one, 2.6.7 with bk7. You might as well
have to replace the drivers/cdrom/cdrom.c with on from a later virsion
(>bk15), as the cdrom device is generally marked write-protected with
bk2 to bk14.
But instead of just trying those kernel versions, I think we might try
and find the changes that might have had the unfortunate side effect. I
am admittedly not too good at that, as I do not even know C (shame on
me).

>And what test procedure? Thisis what I do in such cases:
>
>time { dd if=/dev/zero of=<path/to/bighile> bs=1024k count=<bignum> ; sync ; }
This is what I did.

>I'd be very happy to see a fix for this since backups to DVD-RAM are
>awfully slow at the moment.
I've been after this for months now, before finally posting here...

Regards

David

