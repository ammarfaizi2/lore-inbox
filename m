Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbUBOPXn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 10:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265045AbUBOPW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 10:22:26 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:44767 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264974AbUBOPWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 10:22:21 -0500
Date: Sat, 14 Feb 2004 00:19:01 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0, cdrom still showing directories after being erased
Message-ID: <20040213231900.GI6804@openzaurus.ucw.cz>
References: <20040205203336.GE10547@stud.uni-erlangen.de> <20040205205421.GE11683@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205205421.GE11683@suse.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

> > The linux kernel atapi layer makes a TEST UNIT READY and if the media
> > has changed the cdrom does return an ERR_STAT with a UNIT_ATTENTION
> > which means that the medium has changed. IF that this the case the
> > kernel flushes it's buffers.
> 
> So the drive ought to report media changed if it knowingly over wrote
> the table of contents, for instance.
> 

Why? Media did not change.

You would need cdrom to report media change on each write,
but that would break packet writing. We should fix
kernel/cdrecord, not break hw.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

