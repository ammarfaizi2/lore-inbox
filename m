Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbTI0LrK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 07:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbTI0LrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 07:47:10 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43697 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262425AbTI0LrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 07:47:09 -0400
Date: Sat, 27 Sep 2003 13:47:12 +0200
From: Jens Axboe <axboe@suse.de>
To: Derek Foreman <manmower@signalmarketing.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CDROM_SEND_PACKET oddity
Message-ID: <20030927114712.GJ3416@suse.de>
References: <Pine.LNX.4.58.0309262131110.15317@uberdeity.signalmarketing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0309262131110.15317@uberdeity.signalmarketing.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 26 2003, Derek Foreman wrote:
> The example code from
> http://www.ussg.iu.edu/hypermail/linux/kernel/0202.0/att-0603/01-cd_poll.c
> 
> Does not behave as expected on my 2.6.0-test5 system.  While the command 
> seems to be successfully sent - 2 of my drives report it as an invalid 
> opcode - for the other 2 drives, the buffer comes back all zeros.
> (actually, the buffer's contents will remain in whatever state they're in 
> before the ioctl is called)
> 
> Sending the same command to those 2 drives with SG_IO results in the 
> expected behaviour.

Can you try current -bk? It has some fixes for CDROM_SEND_PACKET.

However, cd_poll should be rewritten to use SG_IO. Pretty trivial
exercise.

-- 
Jens Axboe

