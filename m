Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbVLDWvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbVLDWvg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 17:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbVLDWvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 17:51:36 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:44888 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S932361AbVLDWvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 17:51:35 -0500
Message-ID: <386F0C1C.1040509@tls.msk.ru>
Date: Sun, 02 Jan 2000 11:28:12 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Could not suspend device [VIA UHCI USB controller]: error -22
References: <43923479.3020305@tls.msk.ru> <20051204003130.GB1879@kroah.com>
In-Reply-To: <20051204003130.GB1879@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sun, Dec 04, 2005 at 03:12:41AM +0300, Michael Tokarev wrote:
> 
>>When I try to "standby" (echo standby > /sys/power/state)
>>a 2.6.14 system running on a VIA C3-based system with VIA
>>chipset (suspend to disk never worked on this system --
>>as stated on swsusp website it's due to the lack of some
>>CPU instruction on this CPU [but winXP suspends to disk
>>on this system just fine]), it immediately comes back, with
>>the above error message:
> 
> Can you try 2.6.15-rc4 or newer to see if that fixes this issue for you?

Yes, 2.6.15-rc4 restores previous functionality - the error in
$subject is now gone, and it seems the system goes to standby
as it should, without errors and 'standby process interruptions'.
Thanks.

With the only problem which was here all the time - it comes "back
to C" after less a secound all the disks/monitor/etc are placed
into sleep mode..  Ie,

  ..preparing for standby...
  ..hdd stops spinning..
  ..monitor is turned off..
  ..less-than-a-secound-pause..
  Back to C!
  ..the system goes back, restoring interrupts etc...

I tried various 'wakeup' settings in bios, incl. turning everything
off in that menu - no difference.

The same behaviour is shown by all 2.6 kernels I tried so far
(since 2.6.6 or so).

BTW.. It looks like i should change the $subject now.. ;)

/mjt
