Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267204AbUBNAJQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 19:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267233AbUBNAJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 19:09:16 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:54030 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S267204AbUBNAJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 19:09:14 -0500
Message-ID: <402D68CB.2030803@techsource.com>
Date: Fri, 13 Feb 2004 19:16:11 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Balaji Calidas <balaji@techsource.com>
Subject: IDE DMA problem  [WAS: Re: Getting lousy NFS + tar-pipe throughput
 on 2.4.20]
References: <402D6262.90301@techsource.com>
In-Reply-To: <402D6262.90301@techsource.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have discovered one major problem that I didn't think to check 
before.  I have never before had trouble using DMA with WD drives, VIA 
chipsets, or RH9, so I didn't think to check before, but hdparm reports 
that DMA is disabled for the disk on the workstation I mentioned in my 
earlier post.

So, I tried this:
    hdparm -d1 /dev/hda

And I got this result:
/dev/hda:
 Setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma = 0 (off)

How do I fix this?  Do I have to unmount the filesystem before I can 
change the dma setting?  Why would it be off to begin with?  I know that 
the BIOS is set up right.  Does 2.4.20 not work well with the KT600 chipset?

Thanks.


Timothy Miller wrote:
 > [snip everything about slow NFS performance]



