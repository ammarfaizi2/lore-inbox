Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbVADHuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVADHuh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 02:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVADHuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 02:50:37 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:58047 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261545AbVADHu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 02:50:28 -0500
Date: Tue, 4 Jan 2005 08:46:21 +0100
From: Jens Axboe <axboe@suse.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Adrian Bunk <bunk@stusta.de>, Diego Calleja <diegocg@teleline.es>,
       Willy Tarreau <willy@w.ods.org>, wli@holomorphy.com, aebr@win.tue.nl,
       solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050104074617.GK2825@suse.de>
References: <20050103192844.GA29678@suse.de> <41D9C9B2.2070006@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41D9C9B2.2070006@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03 2005, Bill Davidsen wrote:
> Jens Axboe wrote:
> >On Mon, Jan 03 2005, Bill Davidsen wrote:
> >
> >>SCSI command filtering - while I totally support the idea (and always
> >>have), I miss running cdrecord as a normal user. Multisession doesn't work
> >>as a normal user (at least if you follow the man page) because only root
> >>can use -msinfo. There's also some raw mode which got a permission denied,
> >>don't remember as I was trying something not doing production stuff.
> >
> >
> >So look at dmesg, the kernel will dump the failed command. Send the
> >result here and we can add that command, done deal. 2.6.10 will do this
> >by default.
> >
> 
> Is this enough? I'm building 2.6.10-bk6 on a spare machine to try this 
> on a system with a "scsi" CD interface via USB. The commands appear to 
> go through the same process, but I'll know in an hour or so.
> 
> I was going to look these up before suggesting that they were 
> trustworthy, but I'll take this as a offer to do that and accept! 
> Obviously security comes first, if these are not trustworthy I won't 
> argue for their inclusion.
> 
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on hdb1, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> scsi: unknown opcode 0x01
> scsi: unknown opcode 0x55
> scsi: unknown opcode 0x1e
> scsi: unknown opcode 0x35

You don't have write permissions on the device.

-- 
Jens Axboe

