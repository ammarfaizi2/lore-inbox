Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132111AbRDAJbl>; Sun, 1 Apr 2001 05:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132110AbRDAJbc>; Sun, 1 Apr 2001 05:31:32 -0400
Received: from c213.89.109.26.cm-upc.chello.se ([213.89.109.26]:3332 "EHLO
	pescadero.ampr.org") by vger.kernel.org with ESMTP
	id <S132111AbRDAJbW>; Sun, 1 Apr 2001 05:31:22 -0400
Message-ID: <3AC6F522.93101FDE@ufh.se>
Date: Sun, 01 Apr 2001 11:30:11 +0200
From: Peter Enderborg <pme@ufh.se>
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Version 6.1.6 of the aic7xxx driver availalbe
In-Reply-To: <200104010434.f314Yks62066@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Justin T. Gibbs" wrote:

> >"Justin T. Gibbs" wrote:
> >
> >> >I upgraded to 2.4.3 from 2.4.1 today and I get a lot of recovery on the scs
> >i
> >> >bus.
> >> >I also upgraded to the "latest" aic7xxx driver but still the sam problems.
> >> >A typical revery in my logs.
>
> This really looks like you bus is not up to snuff.  We timeout during
> a write to the drive.  Although the chip has data to write, the target
> has stopped asking for data.  This is a classic symptom of a lost signal
> transition on the bus.  The old driver may have worked in the past
> because it was not quite as fast at driving the bus.  2.2.19 uses the
> "old" aic7xxx driver but includes some performance improvements over 2.2.18.
> The new driver has similar improvements.  Check your cables.  Check
> your terminators.  Etc.
>

I dont think so. The system is very simple. On the 50 pin Fast scsi there is the
CD.
And on the Ultra2 device the IBM harddrive.  On the cable there is a terminator.
(This is the cable from ASUS delivered with the motherboard. Is a balanced pair
cable.) On the
harddrive there is a strap for termination and in the BIOS there is a swich
for ternination. The strip is off. (I have tryed on also) And the BIOS controlled
termination is ON. I have tryed all permutations! But I have found a workaround.
The wide scsi was not in use and have the same connector so  I moved the
harddriv to that bus and now everything works with 2.4.3. Or at least
for a half an hour...  But the drive is a LVD and should be on the Ultra2
connector.



>
> --
> Justin

--
foo!



