Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315967AbSETMwE>; Mon, 20 May 2002 08:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315969AbSETMwD>; Mon, 20 May 2002 08:52:03 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64775 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315967AbSETMwC>; Mon, 20 May 2002 08:52:02 -0400
Date: Mon, 20 May 2002 13:51:57 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: EXT3-fs error (device ide0(3,77)) in ext3_new_inode: error 28
Message-ID: <20020520135157.A22815@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.44.0205201400490.11918-100000@sylfest.hiof.no> <20020520131320.B22425@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 01:13:20PM +0100, Russell King wrote:
> On Mon, May 20, 2002 at 02:07:34PM +0200, Jens Christian Skibakk wrote:
> > When I unpack a tar-archive containing many files (about halv a million)
> > this errors occures in the dmesg output:
> > EXT3-fs error (device ide0(3,77)) in ext3_new_inode: error 28
> 
> ENOSPC - you're out of inodes
> 
> > and the program complins about: No space left on device, but df -h shows
> > that there is over 1G free on the hd.
> 
> try df -i (for inodes)
> 
> > After this error occurs the hd contains errors and need to be checked.
> 
> That's a bug in ext3 - it has (apparantly) been fixed in the CVS version.

BTW, it might be a good idea to post the output of:

tune2fs -l <device>

(from your message above, <device> should be /dev/hdb13 ?)

I've seen one instance where mke2fs got the inode allocation wrong.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

