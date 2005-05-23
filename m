Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVEWSbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVEWSbg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 14:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVEWSbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 14:31:36 -0400
Received: from mail.dvmed.net ([216.237.124.58]:33993 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261906AbVEWSbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 14:31:22 -0400
Message-ID: <42922175.8090005@pobox.com>
Date: Mon, 23 May 2005 14:31:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: DervishD <lkml@dervishd.net>
CC: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] Hard disk LBA sector count is not always the same
References: <20050523121424.GB339@DervishD>
In-Reply-To: <20050523121424.GB339@DervishD>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD wrote:
>     Hi all :)
> 
>     I'm resending this because although it doesn't seem to imply a
> hard disk failure, I have to repartition this disk and I must do it
> using a 2.6 kernel (long story), and I'm afraid that afterwards I
> cannot access the last sectors using 2.4 (since sometimes the disk is
> detected as being 2103 sectors smaller. I would appreciate any help,
> or if someone could point me to a source of information or a more
> appropriate mailing list.
> 
>     I'm having a problem with my primary hard disk: it inconsistently
> reports the number of addressable LBA sectors. At times it reports
> 156301488 (let's call it '301' from now on) which is the correct one
> (I think) and other times it reports 156299375 (I'll call this one
> 299 from now on), a difference of 2103 sectors. But this is not
> arbitrary, I have reproduced the problem. I've done it using a
> self-compiled 2.4.29 kernel and a 2.6.10-1-k7 kernel from Debian
> unstable. These are the steps:
> 
>     STEP 1: From a fully powered off machine, I boot into my 2.4.29
> kernel. The kernel log shows the 299 number, as well as does both
> hdparm -i and hdparm -I. No matter how many times I reboot these
> numbers maintain given I always reboot into 2.4.29.
> 
>     STEP 2: I reboot into my Debian system, using 2.6.10 kernel, and
> now kernel logs show 301 number, as does hdparm -I. But hdparm -i
> shows the 299 number.
> 
>     STEP 3: I reboot again into my Debian system. This time all
> places show the 301 number: the kernel logs, hdparm -i and -I.
> 
>     STEP 4: I reboot into my 2.4.19 kernel, and this time ALL places,
> again, show the 301 number. No matter how many times I reboot into
> 2.4.29 again or even 2.6 (Debian), these numbers doesn't change.
> 
>     I've done the same but starting from full power-off into Debian,
> and the things went like if we start from STEP 2 above. The only
> thing I've seen in the Debian logs that may explain this problem are:
> 
>     current capacity is 156299375
>     native capacity is 156301488

Hard drives have a feature that can reserve a certain amount of space 
away from the user.

Linux IDE often does 'set max' to make 100% of the hard drive visible to 
the OS.

	Jeff



