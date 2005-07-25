Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVGYOAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVGYOAu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 10:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVGYOAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 10:00:50 -0400
Received: from [195.23.16.24] ([195.23.16.24]:47761 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261210AbVGYOAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 10:00:48 -0400
Message-ID: <42E4F08C.1080801@grupopie.com>
Date: Mon, 25 Jul 2005 15:00:44 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Baer <lnx1@gmx.net>
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
Subject: Re: Problem with Asus P4C800-DX and P4 -Northwood-
References: <42E4373D.1070607@gmx.net> <20050725051236.GS8907@alpha.home.local> <42E4E4B0.6050904@gmx.net>
In-Reply-To: <42E4E4B0.6050904@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Baer wrote:
> [...]
> Vmstat for Notebook P4 3.0 GHz 512 MB RAM:
> 
> procs -----------memory---------- ---swap-- -----io---- --system-- 
> ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy 
> id wa
>  1  0      0 179620  14812 228832    0    0    33    21  557   184  3  1 
> 95  1
>  2  0      0 178828  14812 228832    0    0     0     0 1295   819  6  2 
> 92  0
>  1  0      0 175948  14812 228832    0    0     0     0 1090   111 37 17 

This vmstat output doesn't show any input / output happening. Are you 
sure this was taken *while* your test is running? If it is, then all 
files are already in pagecache. The fact that you have free memory at 
all times, and that the run on the notebook takes less than 20 seconds 
confirms this.

The second takes a lot more time to execute. The 1Gb memory does make me 
suspicious, though.

There is a known problem with BIOS that don't set up the mtrr's 
correctly for the whole memory and leave a small amount of memory on the 
top with the wrong settings. Accessing this memory becomes painfully slow.

Can you send the output of /proc/mtrr and try to boot with something 
like "mem=768M" to see if that improves performance on the Desktop P4?

-- 
Paulo Marques - www.grupopie.com

It is a mistake to think you can solve any major problems
just with potatoes.
Douglas Adams
