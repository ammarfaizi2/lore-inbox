Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbUK1SyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbUK1SyE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 13:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUK1SyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 13:54:03 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:42197 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261567AbUK1Sxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 13:53:50 -0500
Date: Sun, 28 Nov 2004 19:53:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Pasi Savolainen <psavo@iki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is controlling DVD speeds via SET_STREAMING supported?
Message-ID: <20041128185329.GB26933@suse.de>
References: <33133.192.168.0.2.1101499190.squirrel@192.168.0.10> <32942.192.168.0.2.1101549298.squirrel@192.168.0.10> <slrncqhqib.19r.psavo@varg.dyndns.org> <33262.192.168.0.2.1101597468.squirrel@192.168.0.10> <slrncqjcve.19r.psavo@varg.dyndns.org> <33050.192.168.0.5.1101651929.squirrel@192.168.0.10> <20041128165257.GA26714@suse.de> <slrncqk3so.19r.psavo@varg.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrncqk3so.19r.psavo@varg.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(don't trim the cc list, please!!)

On Sun, Nov 28 2004, Pasi Savolainen wrote:
> * Jens Axboe <axboe@suse.de>:
> >> > I modified your speed-1.0 to open device O_RDWR, didn't help.
> >> > I modified it to also dump_sense after CMD_SEND_PACKET, it's just
> >> > duplicate packet.
> >> 
> >> No this will definitively not solve this issue. I will try to check this
> >> in the kernel, but because I'm not a kernel developer I will CC Jens
> >> Axboe. Maybe he can help?
> >
> > Just fix the permission on the special file. Additionally, the program
> > must open the device O_RDWR.
> 
> (under 2.6.10-rc2-mm1)
> I ran speed-1.0 program as root and also modified to open the device
> file as O_RDWR. This didn't help, it still reports same error.

Ehm I don't see how that is possible, since that kernel definitely
contains SET_STREAMING as a write safe command. Are you 110% sure you
are running the kernel you think you are?

> Booted into 2.4.28, speed-1.0 didn't do the trick there either. 'sense'
> reported was 00.00.00 though.

Any dmesg errors from 2.4.28? The sense reporting might be a bit broken
there, but if you don't set cgc->quiet it should report the error in the
kernel ring buffer at least.

-- 
Jens Axboe

