Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268013AbUJCRDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268013AbUJCRDS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 13:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268024AbUJCRDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 13:03:17 -0400
Received: from [80.227.59.61] ([80.227.59.61]:59802 "EHLO HasBox.COM")
	by vger.kernel.org with ESMTP id S268013AbUJCRDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 13:03:00 -0400
Message-ID: <416030C0.8090900@0Bits.COM>
Date: Sun, 03 Oct 2004 21:02:56 +0400
From: Mitch <Mitch@0Bits.COM>
User-Agent: Application 0.6+ (X11/20041001)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ottdot@magma.ca, pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3 software suspend (pmdisk) stopped working
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well it appears that Jesse and Kevin are right and irrespective of the 
setting of /sys/power/disk, i can get the machine to suspend by first 
writing 'platform' into the 'disk' file. And it resumes fine ok. Seems 
to be a false alarm on my part Pavel, although the doc's need updating 
and /sys/power/disk made to show the correct supported suspension methods ?

Thanks for the tips guys (i didn't need the c code Jesse)
M

-------- Original Message --------
Subject: Re: 2.6.9-rc3 software suspend (pmdisk) stopped working
Date: Sat, 02 Oct 2004 16:32:33 -0400
From: Jesse <ottdot@magma.ca>
To: Mitch <Mitch@HasBox.COM>
CC: pavel@suse.cz, linux-kernel@vger.kernel.org
References: <415FFE77.7090908@HasBox.COM>

Mitch wrote:
> Hi Jesse,
> 
> as shown below, that is  not one of the options presented to me in my 
> 'disk' file
> 
> % cat /sys/power/disk
> shutdown
> 

My machine shows the same thing. Only shutdown in /sys/power/disk

Grab the code from Documentation/power/swsusp.txt (starts at line 151)

I compiled it to an executable called swsusp and I then run 'swsusp' to
start the suspend process.

2.6.9-rc3 was my first attempt at suspend, and it worked as designed on
the first try.

Jesse

