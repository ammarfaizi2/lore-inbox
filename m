Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262259AbVBVJ6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbVBVJ6r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 04:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVBVJ6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 04:58:46 -0500
Received: from r3az252.chello.upc.cz ([213.220.243.252]:41348 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S262259AbVBVJ56
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 04:57:58 -0500
Message-ID: <421B0224.1050509@ribosome.natur.cuni.cz>
Date: Tue, 22 Feb 2005 10:57:56 +0100
From: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8b) Gecko/20050221
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: memory management weirdness
References: <022120051420.20884.4219EE21000C6C9400005194220588448400009A9B9CD3040A029D0A05@comcast.net>
In-Reply-To: <022120051420.20884.4219EE21000C6C9400005194220588448400009A9B9CD3040A029D0A05@comcast.net>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parag Warudkar wrote:
>>Hi,
>>  I have received no answer to my former question
>>(see http://marc.theaimsgroup.com/?l=linux-kernel&m=110827143716215&w=2).
>>I've spent some more time on that problem and have more or less confirmed
>>it's because of buggy bios. However, the linux kernel doesn't handle properly
>>such case. I've tested 2.4.30-pre1 kernel and latest 2.6.11-rc4 kernel.
>>The conclusion is, that once the machine has physically installed 4x1GB
>>DDR400 DIMM's (bios detects only 3556 or less memory as some buffers
>>are allocated by the Intel 875P chipset and AGP card), the linux 2.6.11*
>>runs up-to 18x slower than when only 2x1GB + 2x 512MB DDR memory is installed.
>>
> 
> Can you enable profiling and then post the profile info for various cases
> - slow and fast? Check out Documentation/basic_profiling.txt in the kernel
> source for understanding how to do this. This might help narrow down the issue.

http://www.natur.cuni.cz/~mmokrejs/tmp/profile-2.6.11-rc4-bk7-(3|4)GB.txt

The 3GB labeled file corresponds to fast case, 4GB is ugly slow.
What can you gather from those files? I've used readprofile but also oprofile
was enabled in kernel. I've left on the web also /proc/profile snapshots along with
System.map file. Maybe oprofile can also be used later to extract info from them.
Many thanks for help!
Martin

