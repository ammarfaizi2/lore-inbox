Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbTD1VV2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 17:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTD1VV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 17:21:27 -0400
Received: from watch.techsource.com ([209.208.48.130]:18855 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S261279AbTD1VV1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 17:21:27 -0400
Message-ID: <3EAD9E94.2000602@techsource.com>
Date: Mon, 28 Apr 2003 17:35:16 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rmoser <mlmoser@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Swap Compression
References: <200304251832440510.00D02649@smtp.comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



rmoser wrote:

>Yeah you did but I'm going into a bit more detail, and with a very tight algorithm.  Heck the algo was originally designed based on another compression algorithm, but for a 6502 packer.  I aimed at speed, simplicity, and minimal RAM usage (hint:  it used 4k for the code AND the compressed data on a 6502, 336 bytes for code, and if I turn it into just a straight packer I can go under 200 bytes on the 6502).
>
>Honestly, I just never looked.  I look in my kernel.  But still, the stuff I defined about swapon options, swap-on-ram, and how the compression works (yes, compressed without headers) is all the detail you need about it to go do it AFAIK.  Preplanning should be done there--done meaning workable, not "the absolute best."
>  
>
I think we might be able to deal with a somewhat more heavy-weight 
compression.  Considering how much faster the compression is than the 
disk access, the better the compression, the better the performance.  

Usually, if you have too much swapping, the CPU usage will drop, because 
things aren't getting done.  That means we have plenty of head room to 
spend time compressing rather than waiting.  The speed over-all would go 
up.  Theoretically, we could run into a situation where the compression 
time dominates.  In that case, it would be beneficial to have a tuning 
options which uses a less CPU-intensive compression algorithm.

>  
>


