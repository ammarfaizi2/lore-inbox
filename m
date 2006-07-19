Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWGSJTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWGSJTu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 05:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbWGSJTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 05:19:50 -0400
Received: from pih-relay05.plus.net ([212.159.14.132]:12756 "EHLO
	pih-relay05.plus.net") by vger.kernel.org with ESMTP
	id S964774AbWGSJTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 05:19:49 -0400
Message-ID: <44BDF8F4.30908@mauve.plus.com>
Date: Wed, 19 Jul 2006 10:18:44 +0100
From: Ian Stirling <tandra@mauve.plus.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: yunfeng zhang <zyf.zeroos@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Improvement on memory subsystem
References: <4df04b840607180303i3d8c8bd0o4d2a24752ec2e150@mail.gmail.com> <200607181218.k6ICIgeS027067@turing-police.cc.vt.edu>
In-Reply-To: <200607181218.k6ICIgeS027067@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Tue, 18 Jul 2006 18:03:54 +0800, yunfeng zhang said:
> 
> 
>>2. Read-ahead process during page-in/out (page fault or swap out) should be
>>based on its VMA to enhance IO efficiency instead of the relative physical pages
>>in swap space.
> 
> 
> But wouldn't that end up causing a seek storm, rather than handling the pages
> in the order that minimizes the total seek distance, no matter where they are
> in memory? Remember - if you have a 2Ghz processor, and a disk that seeks in 1
> millisecond, every seek is (*very* roughly) about 2 million instructions.  So
> if we can burn 20 thousand instructions finding a read order that eliminates
> *one* seek, we're 1.98M instructions ahead.

To paraphrase shakespear - all the world is not a P4 - and all the swap 
devices are not hard disks.

For example - I've got a 486/33 laptop with 12M RAM that I sometimes use 
, with swapping to a 128M PCMCIA RAM card that I got from somewhere.

20K instructions wasted on a device with no seek time is just annoying.

And on my main laptop - I have experimented with swap-over-wifi to a 
large ramdisk on my server - which works quite well. (until the wifi 
connection falls over).
