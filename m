Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271236AbTHCStr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 14:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271244AbTHCSse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 14:48:34 -0400
Received: from mx1.it.wmich.edu ([141.218.1.89]:49591 "EHLO mx1.it.wmich.edu")
	by vger.kernel.org with ESMTP id S271231AbTHCSpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 14:45:31 -0400
Message-ID: <3F2D5843.4040105@wmich.edu>
Date: Sun, 03 Aug 2003 14:45:23 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030722
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Tom Felker <tcfelker@mtco.com>
Subject: Re: Fast DMA CD audio extraction
References: <200308031259.29704.tcfelker@mtco.com>
In-Reply-To: <200308031259.29704.tcfelker@mtco.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Felker wrote:
> Hi,
> 
> I'm trying to get decent performance (e.g. DMA, not PIO) extracting audio with 
> cdparanoia from an new IDE CD-ROM.  The current problem is very slow ripping 
> and very high system CPU time.  hdparm reports DMA is on, and reading data is 
> perfectly fast.
> 
> What kernel versions and patches should I be trying?
> 
> (Please cc: me, emailing in reply to linux.kernel posts munges threading)
> Thanks,
> 
akpm's kernel trees have the ide-dma patch that enables dma in raw mode. 
  Works quite nicely but i'd only use it on really prestine cds. DMA by 
it's nature doesn't give the best error reporting when dealing with raw 
data cds like audio cds. I've never had a problem with it though, even 
on cds with scratches.

