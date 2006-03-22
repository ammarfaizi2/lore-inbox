Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWCVEll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWCVEll (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 23:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWCVEll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 23:41:41 -0500
Received: from 220-130-178-143.HINET-IP.hinet.net ([220.130.178.143]:34298
	"EHLO areca.com.tw") by vger.kernel.org with ESMTP id S1750753AbWCVElk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 23:41:40 -0500
Message-ID: <003001c64d6a$e6d26ca0$b100a8c0@erich2003>
From: "erich" <erich@areca.com.tw>
To: "Matti Aarnio" <matti.aarnio@zmailer.org>
Cc: "Dax Kelson" <dax@gurulabs.com>, <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Al Viro" <viro@ftp.linux.org.uk>
References: <20060318044056.350a2931.akpm@osdl.org> <Pine.LNX.4.64.0603192016110.32337@mooru.gurulabs.com> <Pine.LNX.4.64.0603212345460.20655@nacho.alt.net> <20060322033718.GA21614@mea-ext.zmailer.org>
Subject: Re: New Areca driver in 2.6.16-rc6-mm2
Date: Wed, 22 Mar 2006 12:41:33 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.1830
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
X-OriginalArrivalTime: 22 Mar 2006 04:36:58.0859 (UTC) FILETIME=[4191E3B0:01C64D6A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

I had met this problem at my Fab before.
But this problem seem not came from the issue of driver version change.
I had test it with my older version of areca driver and it cause same
problem.
I did this testing with EXT2 file system and I got dump messages as
following message.
But When I used EXT3 file system and run same testing, it worked fine.

 attempt to access beyond end of device
  sdb1: rw=0, want=134744080, limit=128002016
  attempt to access beyond end of device
  sdb1: rw=0, want=134744080, limit=128002016
  attempt to access beyond end of device
  sdb1: rw=0, want=134744080, limit=128002016
  attempt to access beyond end of device
  sdb1: rw=0, want=134744080, limit=128002016
  attempt to access beyond end of device
  sdb1: rw=0, want=134744080, limit=128002016
  attempt to access beyond end of device
  sdb1: rw=0, want=134744080, limit=128002016
  attempt to access beyond end of device
  sdb1: rw=0, want=134744080, limit=128002016

Now I have time to research this problem.
Hope that I can give you more information about it.

Best Regards
Erich Chen

----- Original Message ----- 
From: "Matti Aarnio" <matti.aarnio@zmailer.org>
To: "Chris Caputo" <ccaputo@alt.net>
Cc: "Dax Kelson" <dax@gurulabs.com>; <linux-kernel@vger.kernel.org>; 
<erich@areca.com.tw>
Sent: Wednesday, March 22, 2006 11:37 AM
Subject: Re: New Areca driver in 2.6.16-rc6-mm2


> On Tue, Mar 21, 2006 at 11:49:32PM +0000, Chris Caputo wrote:
>> On Sun, 19 Mar 2006, Dax Kelson wrote:
>> > On Sat, 18 Mar 2006, Andrew Morton wrote:
>> > > SCSI fixes
>> > >
>> > > +areca-raid-linux-scsi-driver-update4.patch
>> > >
>> > > Update areca-raid-linux-scsi-driver.patch
>> >
>> > Has anyone had a chance to review this new update to see if it now 
>> > passes
>> > muster for mainline inclusion?
>>
>> Unfortunately when the new driver is applied to 2.6.15.6 a bonnie++ test
>> results in the following endless spew:
>
> Curious...   I didn't encounter this phenomena, but then, my 0.75 TB
> raid5 volume is practically empty...
>
> For the development phase it would be most useful, if  the driver
> would be available in similar "this will compile for your currently
> running kernel, or some other you care to name and have its config.h
> files at hand"  as e.g. Nvidia drivers are (except that arcmsr is
> in "all source form", whereas NV has this magic object blob..)
>
> Such would allow (at least for me) to have a wee bit faster cycle
> with "pick vendor kernel, add this and that custom module"
>
> I was apalled to learn that full cycle kernel compilation takes
> _hours_ these days (Pentium-4 HT, 2.4 GHz, 2 GB memory -- and it
> is about as slow as my first kernel compilation experience with
> a 386/33MHz way back in ...)
>
>>   ...
>>   attempt to access beyond end of device
>>   sdb1: rw=0, want=134744080, limit=128002016
>>   ...
>>
>> I have emailed the details to Erich.
>>
>> Chris
>
> /Matti Aarnio 

