Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbUBXD77 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 22:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbUBXD77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 22:59:59 -0500
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:53381 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S262152AbUBXD75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 22:59:57 -0500
Date: Mon, 23 Feb 2004 21:00:00 -0700
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: jabbera@student.umass.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: libata/iswraid DMA Timeout
Message-ID: <20040224040000.GA12298@bounceswoosh.org>
Mail-Followup-To: jabbera@student.umass.edu, linux-kernel@vger.kernel.org
References: <1077580276.403a91f4094fe@mail-www4.oit.umass.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1077580276.403a91f4094fe@mail-www4.oit.umass.edu>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Feb 23 at 18:51, jabbera@student.umass.edu wrote:
>Sorry never posted to this list so bear with me. 
>I am currently using kernel version 2.4.25 i386 with libata and iswraid. 
>Note: iswraid is for 2.4.22, but it applied to 2.4.25 without issue. 
> 
>I am not sure which patch this problem is in relation to, but here is the 
>information. 
> 
>I was using a php script to move a bunch of my files around the file system 
>when my system locks up and I see: 
>ata1: DMA timeout, stat 0x21 
>ATA: abnormal status 0x59 on port 0xC407 

0x59 is the status that the drive sends when it has a block in error
and wants to transmit said block.  The LBA in the task file after the
bad block is transferred is the location of the error.

I think that the drive you're copying from had a hard ECC error.
Maybe see if you can try to read all the files on that drive and see
if you can find a bad block.


-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

