Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130487AbRDARRm>; Sun, 1 Apr 2001 13:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131191AbRDARRc>; Sun, 1 Apr 2001 13:17:32 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:37648 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S130487AbRDARRW>; Sun, 1 Apr 2001 13:17:22 -0400
Message-Id: <200104011716.f31HGas68857@aslan.scsiguy.com>
To: Peter Enderborg <pme@ufh.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: Version 6.1.6 of the aic7xxx driver availalbe 
In-Reply-To: Your message of "Sun, 01 Apr 2001 11:30:11 +0200."
             <3AC6F522.93101FDE@ufh.se> 
Date: Sun, 01 Apr 2001 11:16:36 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> >A typical revery in my logs.
>>
>> This really looks like you bus is not up to snuff.  We timeout during
>> a write to the drive.  Although the chip has data to write, the target
>> has stopped asking for data.  This is a classic symptom of a lost signal
>> transition on the bus.  The old driver may have worked in the past
>> because it was not quite as fast at driving the bus.  2.2.19 uses the
>> "old" aic7xxx driver but includes some performance improvements over 2.2.18.
>> The new driver has similar improvements.  Check your cables.  Check
>> your terminators.  Etc.
>>
>
>I dont think so. The system is very simple. On the 50 pin Fast scsi there is
>the CD.  And on the Ultra2 device the IBM harddrive.  On the cable there is
>a terminator.  (This is the cable from ASUS delivered with the motherboard.
>Is a balanced pair cable.) On the harddrive there is a strap for termination
>and in the BIOS there is a swich for ternination. The strip is off. (I have
>tryed on also) And the BIOS control led termination is ON. I have tryed all
>permutations! But I have found a workaround.  The wide scsi was not in use
>and have the same connector so  I moved the harddriv to that bus and now
>everything works with 2.4.3. Or at least for a half an hour...  But the drive
>is a LVD and should be on the Ultra2 connector.

I've seen so many bug reports lately, that I can't recall your exact
configuration.  You make it sound as if you have an aic7890 with a
50 pin bus and a 68 pin bus.  If this is the case, it does not sound
like your termination is properly setup for having devices on "either
side" of the controller.  The controller termination should probably
be off.

--
Justin
