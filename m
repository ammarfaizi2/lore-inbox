Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbTLWQ4l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 11:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbTLWQ4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 11:56:41 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:57493 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262030AbTLWQ4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 11:56:20 -0500
Date: Tue, 23 Dec 2003 17:56:01 +0100
From: Jens Axboe <axboe@suse.de>
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-mm1
Message-ID: <20031223165601.GE1601@suse.de>
References: <20031223163245.GA23184@suse.de> <Pine.LNX.4.44.0312231740590.1079-100000@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312231740590.1079-100000@neptune.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23 2003, Pascal Schmidt wrote:
> On Tue, 23 Dec 2003, Jens Axboe wrote:
> 
> >> Since the atapi-mo patch is mine, is there something I need to do?
> > Nah don't worry about it, Andrew and I just agreed that I'd merge the
> > remaining changes once 2.6.0-mm1 was up. Basically, MO needs to set
> > _RAM capability so we can kill the various MO checks.
> 
> Please remember that you can't send the MO drive any DVD-RAM specific
> commands and expect it to work. The special-casing in the probe routine
> in ide-cd is there for a reason, and I don't think calling
> cdrom_dvdram_open_write would be a good idea, either. I haven't actually
> looked at that routine, but if it sends anything to the drive, my MO
> drive won't like it one bit. It will at best error out and then
> cdrom_dvdram_open_write will error out, too, disallowing opening for
> write, right?

The changes are nothing like that. Don't confuse CDC_DVD_RAM and CDC_RAM
- the latter just means that it is ok to open this media for random
writes so we don't have to check for three types of different devices.

-- 
Jens Axboe

