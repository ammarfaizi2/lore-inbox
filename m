Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbUEOKr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbUEOKr5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 06:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbUEOKr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 06:47:57 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51133 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261793AbUEOKrz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 06:47:55 -0400
Date: Sat, 15 May 2004 12:47:53 +0200
From: Jens Axboe <axboe@suse.de>
To: gboyce@badbelly.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Burning CDs with a CD-ROM is a bad idea
Message-ID: <20040515104752.GC24600@suse.de>
References: <Pine.LNX.4.58.0405141352540.7746@buddha.badbelly.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405141352540.7746@buddha.badbelly.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14 2004, gboyce@badbelly.com wrote:
> Hello folks,
> 
> Yesterday I made a slight thinko while attempting to burn a CD.  Rather 
> than specifying dev=/dev/hdd, I add dev=/dev/hdc, which is my CD-ROM 
> drive rather than my cd burner.  Whoops!
> 
> Now, I believe I've done this before, and recieved an error message.  
> However, in this particular case with 2.6.6, the system behaved a bit 
> different.
> 
> bio 00000000, biotail 00000000, buffer 00000000, data 00000000, len 0
> cdb: 1e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x02)
> ide-cd: cmd 0x1e timed out
> hdc: lost interrupt

Looks like one of the burning commands confused the drive so much, that
it now refuses to do anything (the above command is a simple medium
removal prevention command, doesn't even need a data transfer).

So I don't think this is a kernel problem. Well maybe we could reset the
device and see if it recovers (do you see any resets in the log?)

-- 
Jens Axboe

