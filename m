Return-Path: <linux-kernel-owner+w=401wt.eu-S1755207AbXABDA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755207AbXABDA4 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 22:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755214AbXABDA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 22:00:56 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:9153 "EHLO
	pd3mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755207AbXABDAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 22:00:55 -0500
Date: Mon, 01 Jan 2007 21:00:51 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Suspend problems on 2.6.20-rc2-git1
In-reply-to: <200701020047.02918.rjw@sisk.pl>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
       Dave Jones <davej@redhat.com>
Message-id: <4599CAE3.1070103@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <459771A2.6060301@shaw.ca> <200612311427.02175.rjw@sisk.pl>
 <200612311724.11423.rjw@sisk.pl> <200701020047.02918.rjw@sisk.pl>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
>>>> Secondly, if you try and suspend manually it claims there is no swap 
>>>> device available when there clearly is:
>>>>
>>>> [root@localhost rob]# cat /proc/swaps
>>>> Filename                                Type            Size    Used 
>>>> Priority
>>>> /dev/mapper/VolGroup00-LogVol01         partition       1048568 0       -1
>>>> [root@localhost rob]# echo disk > /sys/power/state
>>>> bash: echo: write error: No such device or address
>>> Hm, at first sight it looks like something broke the suspend to swap
>>> partitions located on LVM.  For now I have no idea what it was.
>> _Or_ something broke your initrd setup.
> 
> No, this is a kernel problem, I think.
> 
> Can you please check if the appended patch fixes the issue?
> 
> Thanks,
> Rafael
> 
> 
> ---
>  include/linux/swap.h |    2 +-
>  kernel/power/swap.c  |    9 +++++----
>  kernel/power/user.c  |    7 ++++---
>  mm/swapfile.c        |    8 +++++++-
>  4 files changed, 17 insertions(+), 9 deletions(-)

Yes, this seems to solve the problem for me..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/
