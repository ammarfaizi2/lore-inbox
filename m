Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265438AbTL2XY6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 18:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265461AbTL2XY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 18:24:58 -0500
Received: from ms-smtp-03-qfe0.nyroc.rr.com ([24.24.2.57]:39070 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S265438AbTL2XYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 18:24:54 -0500
Message-ID: <3FF0B7F0.2020403@maine.rr.com>
Date: Mon, 29 Dec 2003 18:25:36 -0500
From: "David B. Stevens" <dsteven3@maine.rr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Molina <tmolina@cablespeed.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain> <Pine.LNX.4.58.0312291420370.1586@home.osdl.org> <Pine.LNX.4.58.0312291755080.5835@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.58.0312291755080.5835@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

Have you tried lowering the read ahead in 2.6 to 8.

I don't know what you are doing with your workload but it is possible 
that you are transferring useless data and clogging the plumbing a bit.

Cheers,
  Dave



Thomas Molina wrote:

>It certainly looks like DMA is enabled.  Under 2.4 I get:
>
>[root@lap root]# hdparm /dev/hda
>
>/dev/hda:
> multcount    = 16 (on)
> IO_support   =  1 (32-bit)
> unmaskirq    =  1 (on)
> using_dma    =  1 (on)
> keepsettings =  0 (off)
> readonly     =  0 (off)
> readahead    =  8 (on)
> geometry     = 2584/240/63, sectors = 39070080, start = 0
>
>
>Under 2.6  I get:
>
>[root@lap root]# hdparm /dev/hda
>
>/dev/hda:
> multcount    = 16 (on)
> IO_support   =  1 (32-bit)
> unmaskirq    =  1 (on)
> using_dma    =  1 (on)
> keepsettings =  0 (off)
> readonly     =  0 (off)
> readahead    = 256 (on)
> geometry     = 38760/16/63, sectors = 39070080, start = 0
>  
>


