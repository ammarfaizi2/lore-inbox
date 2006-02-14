Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422775AbWBNT4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422775AbWBNT4Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 14:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422776AbWBNT4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 14:56:25 -0500
Received: from smtpout.mac.com ([17.250.248.85]:55776 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1422775AbWBNT4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 14:56:24 -0500
In-Reply-To: <43F223EF.1000309@cfl.rr.com>
References: <Pine.LNX.4.44L0.0602131601220.4754-100000@iolanthe.rowland.org> <43F11A9D.5010301@cfl.rr.com> <BCC8C7FA-25A2-4460-A667-5AA88BF5BC6D@mac.com> <43F13BDF.3060208@cfl.rr.com> <DD0B9449-14AF-47D1-8372-DDC7E896DBC2@mac.com> <43F17850.8080600@cfl.rr.com> <F157E3C4-0D62-413C-B08B-91A567B8C09B@mac.com> <43F223EF.1000309@cfl.rr.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D2DF8AE9-51A0-42DF-8346-0EF4C264627D@mac.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Flames over -- Re: Which is simpler?
Date: Tue, 14 Feb 2006 14:55:56 -0500
To: Phillip Susi <psusi@cfl.rr.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 14, 2006, at 13:39, Phillip Susi wrote:
>>> I think most users prefer a system that works right when you use  
>>> it right to one that doesn't break quite as badly when you do  
>>> something stupid.
>>
>> I think you just proved my point.  Running the "sync" command a  
>> couple times then unplugging the USB stick basically never results  
>> in data loss even if the filesystem is mounted.  Spontaneously  
>> switching block devices under a mounted filesystem is guaranteed  
>> to either panic the machine or cause massive data corruption or both.
>
> But who cares?  There are plenty of really stupid things users can  
> do to hose their system, it isn't right to prevent them from doing  
> something perfectly reasonable just because it reduces the damage  
> done when they do something completely unreasonable.

How is swapping USB devices while suspended unreasonable?  Come to  
think of it, I did it inadvertently about 15 minutes ago with my  
PowerBook (while booted into Mac OS).  I had a USB key that I was  
copying a file to for someone.  After shutting the lid, I unplugged  
mouse, USB key, and power block.  About 30 minutes later I had  
somebody else with a key who wanted to give me a file.  I had the key  
plugged in before the laptop was finished waking up from sleep.  Now,  
I don't know for certain that neither key had a serial number, but  
the two I have here in my hand certainly don't, and I could _easily_  
see somebody swapping USB keys not knowing that they're "not supposed  
to do that" and getting massive data corruption when the filesystem  
reads and writes pages from a completely different block device.

>> SCSI != USB.  Users generally don't expect to hotplug SCSI devices  
>> while booted and running (with the exception of some _really_  
>> expensive hotplug-bays where we expect the admin to know what the  
>> hell they're doing).  On the other hand, users _do_ expect to  
>> hotplug random USB devices whenever they feel like it.
>
> So because SCSI is more expensive than USB, it is ok to assume it  
> will only be used by people who know what they are doing?  And  
> since USB will be used by people who don't know what they are  
> doing, we must assume they will always do silly things ( swap or  
> modify the drive while suspended ), at the expense of those who don't?

Did you read what I wrote?  People don't generally expect to randomly  
plug and unplug SCSI drives whenever they feel like it.  They _do_  
expect to randomly plug and unplug USB drives, mice, keyboards,  
tablets, network adapters, etc, because _everything_ supports such  
random plugging.

Creating an extremely odd and hard to predict failure mode (when you  
reconnect USB devices while suspended on hardware that doesn't  
support proper USB suspend) with a high probability of causing data  
corruption or crashes is wrong.  Especially since you could easily  
teach users that "You need to eject USB things before you sleep the  
computer _or_ just fix the kernel to do it for you.  That's probably  
something we should be doing for all network filesystems anyways.

Cheers,
Kyle Moffett

--
I didn't say it would work as a defense, just that they can spin that  
out for years in court if it came to it.
   -- Rob Landley



