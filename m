Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbUCCVhL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 16:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbUCCVhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 16:37:11 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:17546 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261158AbUCCVhJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 16:37:09 -0500
Message-ID: <4046512F.9000901@tmr.com>
Date: Wed, 03 Mar 2004 16:42:07 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ftruncate64
References: <1tgNg-8o9-5@gated-at.bofh.it> <1vBDZ-48V-7@gated-at.bofh.it>
In-Reply-To: <1vBDZ-48V-7@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Thu, Feb 26, 2004 at 05:23:10AM +0600, Anton Petrusevich wrote:
> 
> 
>>ftruncate64(1, 2199023255552)           = -1 EFBIG (File too large)
> 
> 
> Depends on your fs, some fs's will allow you to create much larger
> files that others:
> 
> cw@pain:~$ truncate -c -s100t big-file
> cw@pain:~$ ls -lh big-file
> -rw-r--r--    1 cw       cw           100T Mar  3 02:05 big-file
> 
> 
> Note, you might need a 64-bit system to be able to write to all of
> that because the index into the buffer-cache is an unsigned long.  For
> me on my notebook I can't write past 8T.

If that's an issue I want a laptop like yours! Disk size aside, writing 
8T would take longer than the MTBF of both the disk and the owner :-(
