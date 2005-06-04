Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVFDDsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVFDDsi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 23:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVFDDsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 23:48:38 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:5415 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261227AbVFDDsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 23:48:35 -0400
Date: Fri, 03 Jun 2005 21:47:33 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: DMA timeouts & errors when using Sandisk CF for root.
In-reply-to: <4bufp-3G0-15@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <42A12455.9050607@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4bufp-3G0-15@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> I have a small VIA based system with a 512MB CF disk for
> the 'hard drive'.  It seems to work OK, but I am getting some
> DMA timeouts and errors upon boot.
> 
> kernel is 2.6.11.  I saw the same problem with FC2's 2.6.5 default kernel.
> 
>  From dmesg:
> 
> hda: max request size: 128KiB
> hda: 1000944 sectors (512 MB) w/1KiB Cache, CHS=993/16/63, DMA
> hda: cache flushes not supported
>  hda:<4>hda: dma_timer_expiry: dma status == 0x21
> hda: DMA timeout error
> hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }

What kind of CF-IDE adapter are you using? This looks like a CF card 
which supports DMA in an adapter which doesn't hook up the DMA lines 
properly, therefore the DMA times out when the kernel tries to use it. 
You can use a "nodma" option on the kernel command line to disable DMA, 
I think..

I've seen some newer adapters that have jumper settings for "DMA" or 
"non-DMA" on them..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/
