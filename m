Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315388AbSH0ITR>; Tue, 27 Aug 2002 04:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315406AbSH0ITR>; Tue, 27 Aug 2002 04:19:17 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25096 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315388AbSH0ITR>; Tue, 27 Aug 2002 04:19:17 -0400
Date: Tue, 27 Aug 2002 09:23:16 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jeff Chua <jchua@fedex.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] initrd >24MB corruption
Message-ID: <20020827092316.A13184@flint.arm.linux.org.uk>
References: <1030355656.16618.32.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0208270758080.15296-100000@boston.corp.fedex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208270758080.15296-100000@boston.corp.fedex.com>; from jchua@fedex.com on Tue, Aug 27, 2002 at 08:05:14AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 08:05:14AM +0800, Jeff Chua wrote:
> On 26 Aug 2002, Alan Cox wrote:
> > > 	RAMDISK: Compressed image found at block 0 ... then stuck!
> > Force a 1K block size when you make the fs
> 
> That was the default for mke2fs.
> 
> Tried compress instead of gzip. Same problem. I guess the compressed file
> is too big for the kernel. The 8MB compressed (from 24MB) didn't work. 6MB
> compressed from 18MB worked. The 24MB filesystem has just one extra junk
> file in /tmp to fill up the filesystem to 90% and this caused the system
> to hang.
> 
> I'm thinking it could be the ungzip function in the kernel that's causing
> the problem.

Out of curiosity, how much RAM do you have available?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

