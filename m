Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271843AbRHUT4F>; Tue, 21 Aug 2001 15:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271844AbRHUTzz>; Tue, 21 Aug 2001 15:55:55 -0400
Received: from smtp.linuxsecurity.com ([209.11.107.5]:13828 "HELO
	juggernaut.guardiandigital.com") by vger.kernel.org with SMTP
	id <S271843AbRHUTzk>; Tue, 21 Aug 2001 15:55:40 -0400
Message-ID: <3B82BCCB.377BCC4@guardiandigital.com>
Date: Tue, 21 Aug 2001 15:55:55 -0400
From: Nick DeClario <nick@guardiandigital.com>
Reply-To: nick@guardiandigital.com
Organization: Guardian Digital, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Determining maximum partition size on a hard disk
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to calculate the maximum size a partition can be on a hard
drive and I ran into some problems I don't fully understand.  

First I found that the maximum size of the drive Linux reports is not
the maximum size I get when I calculate it from the drives geometry. 
Secondly, the total drive space reported by linux is not the amount
available for the maximum partition.

For example, I have a 4.3Gb disk.  The drives geometry is 525 cylinders,
255 heads and 63 sectors (525 * 255 * 63 * 512 = 4318272000 or
4.318Gb).  

This is an IDE disk so I found in /proc/ide/hdx/capacity a block size
8439184, which when divided by 2048 is 4120.7, ~200Mb less than what I
calculated as the disk size.  

Finally, using a program such as fdisk or sfdisk I create a partition
manually to be the maximum amount allowed, which turns out to be 4217041
blocks, or, when divided by 1024 is 4118.2.

I assume that the difference between the maximum size that linux reports
and the maximum partition size is due to linux leaving room for a MBR
and such.  If so how do I go about calculating this?  Also why does the
size of the drive I calculate out by using the drives geometry differ so
much from the amount Linux reports?  I thought maybe Linux set 1MB=1000k
but that doesn't seem to case.

Any information or a push in the right direction would be appreciated,
thanks! 

Regards,
	-Nick DeClario
