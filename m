Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315929AbSETMN3>; Mon, 20 May 2002 08:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315934AbSETMN2>; Mon, 20 May 2002 08:13:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49415 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315929AbSETMN0>; Mon, 20 May 2002 08:13:26 -0400
Date: Mon, 20 May 2002 13:13:20 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jens Christian Skibakk <jenscski@sylfest.hiof.no>
Cc: linux-kernel@vger.kernel.org, jens.c.skibakk@hiof.no
Subject: Re: EXT3-fs error (device ide0(3,77)) in ext3_new_inode: error 28
Message-ID: <20020520131320.B22425@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.44.0205201400490.11918-100000@sylfest.hiof.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 02:07:34PM +0200, Jens Christian Skibakk wrote:
> When I unpack a tar-archive containing many files (about halv a million)
> this errors occures in the dmesg output:
> EXT3-fs error (device ide0(3,77)) in ext3_new_inode: error 28

ENOSPC - you're out of inodes

> and the program complins about: No space left on device, but df -h shows
> that there is over 1G free on the hd.

try df -i (for inodes)

> After this error occurs the hd contains errors and need to be checked.

That's a bug in ext3 - it has (apparantly) been fixed in the CVS version.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

