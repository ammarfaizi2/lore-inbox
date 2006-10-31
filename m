Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422770AbWJaBEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422770AbWJaBEJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 20:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422771AbWJaBEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 20:04:09 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:52495 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1422770AbWJaBEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 20:04:06 -0500
Message-ID: <4546A0D9.7010805@shadowen.org>
Date: Tue, 31 Oct 2006 01:03:21 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Andy Whitcroft <apw@shadowen.org>
CC: Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@google.com>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
References: <20061029160002.29bb2ea1.akpm@osdl.org>	<45461977.3020201@shadowen.org>	<45461E74.1040408@google.com> <20061030084722.ea834a08.akpm@osdl.org> <454631C1.5010003@google.com> <45463481.80601@shadowen.org> <454662C5.8070607@shadowen.org>
In-Reply-To: <454662C5.8070607@shadowen.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft wrote:
> Andy Whitcroft wrote:
>> Martin Bligh wrote:
>>>>> Setting up network interfaces:
>>>>>      lo
>>>>>     lo        IP address: 127.0.0.1/8
>>>>> 7[?25l[1A[80C[10D[1;32mdone[m8[?25h    eth0
>>>>>               No configuration found for eth0
>>>>> 7[?25l[1A[80C[10D[1munused[m8[?25h    eth1
>>>>>             No configuration found for eth1
>>>>>
>>>>> for all 8 cards.
>>>> What version of udev is being used?
>>> Buggered if I know. If we could quit breaking it, that'd be good though.
>>> If it printed its version during boot somewhere, that'd help too.
>>>
>>>> Was CONFIG_SYSFS_DEPRECATED set?
>>> No.
>>>
>>> M.
>> These all sounds pretty old.  I'll rerun them all with
>> CONFIG_SYSFS_DEPRECATED set and see what pans out.
>>
> 
> Ok, these have all popped through.  Three of the four seems unchanged,
> so I am inclined to think that turning on SYSFS_DEPRECATED has not
> helped us.
> 
> One seems to have blown up differently:
> 
[...]

Ok, it was suggested that we revert all of gregkh's patches as a first
stab at a cuplprit.  I reverted the changes between the following two
patches (inclusive):

    gregkh-driver-w1-ioremap-balanced-with-iounmap.patch
    call-platform_notify_remove-later.patch

The first result in is a positive test complete on that machine.  Will
check the remainder of the tests in the morning.

-apw
