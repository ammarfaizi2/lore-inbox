Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270814AbRH1MXP>; Tue, 28 Aug 2001 08:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270818AbRH1MXF>; Tue, 28 Aug 2001 08:23:05 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:7213 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S270814AbRH1MWs>;
	Tue, 28 Aug 2001 08:22:48 -0400
Message-ID: <20010828142315.A20775@win.tue.nl>
Date: Tue, 28 Aug 2001 14:23:15 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: nick@guardiandigital.com, linux-kernel@vger.kernel.org
Subject: Re: Determining maximum partition size on a hard disk
In-Reply-To: <3B82BCCB.377BCC4@guardiandigital.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3B82BCCB.377BCC4@guardiandigital.com>; from Nick DeClario on Tue, Aug 21, 2001 at 03:55:55PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2001 at 03:55:55PM -0400, Nick DeClario wrote:

> I am trying to calculate the maximum size a partition can be on a hard
> drive and I ran into some problems I don't fully understand.  
> 
> First I found that the maximum size of the drive Linux reports is not
> the maximum size I get when I calculate it from the drives geometry. 
> Secondly, the total drive space reported by linux is not the amount
> available for the maximum partition.
> 
> For example, I have a 4.3Gb disk.  The drives geometry is 525 cylinders,
> 255 heads and 63 sectors (525 * 255 * 63 * 512 = 4318272000 or
> 4.318Gb).  
> 
> This is an IDE disk so I found in /proc/ide/hdx/capacity a block size
> 8439184, which when divided by 2048 is 4120.7, ~200Mb less than what I
> calculated as the disk size.

I don't know why you would want to divide by 2048.
Multiply by 512 and find 512*8439184 = 4320862208 bytes.
Since that is more than you thought you had, be happy.

> I assume that the difference between the maximum size that linux reports
> and the maximum partition size is due to linux leaving room for a MBR

No. There are rounding differences. The disk capacity is not an integral
number of cylinders and you lose if you insist on alignment.

Find a lot of details in the Large Disk Howto.

> I thought maybe Linux set 1MB=1000k but that doesn't seem to case.

Well, 1 M = 1000 k by definition of the SI system of units.
This has nothing to do with Linux.
But if you are confused about units, just compute in bytes.
