Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbVI1C4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbVI1C4R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 22:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965259AbVI1C4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 22:56:16 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.118]:27553 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S965257AbVI1C4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 22:56:16 -0400
Date: Tue, 27 Sep 2005 22:55:20 -0400 (Eastern Daylight Time)
From: Parag Warudkar <kernel-stuff@comcast.net>
To: david.ronis@mcgill.ca
cc: linux-kernel@vger.kernel.org
Subject: RE: problem with 2.6.13.[0-2]
Message-ID: <Pine.WNT.4.63.0509272247550.2588@home-comp>
Organization: Not Much But I Keep Trying
X-X-Sender: kernel-stuff@mail.comcast.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> DMA is on in both 2.6.12.6 and in 2.6.13.2.  Here's what hdparm
> /dev/hda gives:
>
> in 2.6.12.6:
>
> /dev/hda:
>  multcount    = 16 (on)
>  IO_support   =  0 (default 16-bit)
>  unmaskirq    =  0 (off)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  readonly     =  0 (off)
>  readahead    = 256 (on)
>  geometry     = 65535/16/63, sectors = 195371568, start = 0
>
> in 2.6.13.2 it's the same, except for
>
> multcount    =  0 (off)
>
> Could this be the problem, and if so, would setting multcount to on
> fix it? (I take it hdparm -m 16 /dev/hda would do it)

I doubt if multcount will make a difference, but you can try.
Probably next best thing to do is profile the slow kernel to find where it 
is spending time. (pass profile=2 on kernel command line and use 
readprofile or use oprofile).

Did you try hdparm -tT /dev/hda? It's going to be slow, thats for sure 
from what you described but try that and then post dmesg (for both 
kernels) and profile results - may be someone will get a clue from that.

Parag

