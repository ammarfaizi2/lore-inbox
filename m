Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbVADS62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVADS62 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 13:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbVADS62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 13:58:28 -0500
Received: from mail.tmr.com ([216.238.38.203]:1807 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261697AbVADS6G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 13:58:06 -0500
Date: Tue, 4 Jan 2005 13:34:39 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Jens Axboe <axboe@suse.de>
cc: Adrian Bunk <bunk@stusta.de>, Diego Calleja <diegocg@teleline.es>,
       Willy Tarreau <willy@w.ods.org>, wli@holomorphy.com, aebr@win.tue.nl,
       solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
In-Reply-To: <20050104074617.GK2825@suse.de>
Message-ID: <Pine.LNX.3.96.1050104132945.2324C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2005, Jens Axboe wrote:

> On Mon, Jan 03 2005, Bill Davidsen wrote:
> > Jens Axboe wrote:
> > >On Mon, Jan 03 2005, Bill Davidsen wrote:
> > >
> > >>SCSI command filtering - while I totally support the idea (and always
> > >>have), I miss running cdrecord as a normal user. Multisession doesn't work
> > >>as a normal user (at least if you follow the man page) because only root
> > >>can use -msinfo. There's also some raw mode which got a permission denied,
> > >>don't remember as I was trying something not doing production stuff.
> > >
> > >
> > >So look at dmesg, the kernel will dump the failed command. Send the
> > >result here and we can add that command, done deal. 2.6.10 will do this
> > >by default.
> > >
> > 
> > Is this enough? I'm building 2.6.10-bk6 on a spare machine to try this 
> > on a system with a "scsi" CD interface via USB. The commands appear to 
> > go through the same process, but I'll know in an hour or so.
> > 
> > I was going to look these up before suggesting that they were 
> > trustworthy, but I'll take this as a offer to do that and accept! 
> > Obviously security comes first, if these are not trustworthy I won't 
> > argue for their inclusion.
> > 
> > kjournald starting.  Commit interval 5 seconds
> > EXT3 FS on hdb1, internal journal
> > EXT3-fs: mounted filesystem with ordered data mode.
> > scsi: unknown opcode 0x01
> > scsi: unknown opcode 0x55
> > scsi: unknown opcode 0x1e
> > scsi: unknown opcode 0x35
> 
> You don't have write permissions on the device.

Nope, /dev/hdc is owned by davidsen, group disk, permissions 660. I am me
and in group disk as well. And I can write single session CDs without
error, it's only the use -msinfo which fails, the first burn works just
fine.

I think all of that but the permissions stuff was in the original post...
See the man page and/or README.multi if you don't use multisession,
-msinfo just returns the size of the initial session(s) already written.

I can aslo write as me using growisofs, but it only works on DVD, kind of
overkill for what I'm doing.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

