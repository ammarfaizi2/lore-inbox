Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWFPWLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWFPWLy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 18:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWFPWLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 18:11:54 -0400
Received: from lucidpixels.com ([66.45.37.187]:926 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751420AbWFPWLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 18:11:53 -0400
Date: Fri, 16 Jun 2006 18:11:52 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: daniel+devel.linux.lkml@flexserv.de, linux-kernel@vger.kernel.org
Subject: Re: Bug: XFS internal error XFS_WANT_CORRUPTED_RETURN
In-Reply-To: <Pine.LNX.4.61.0606170005150.27136@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0606161811280.10656@p34.internal.lan>
References: <878xnx19bs.fsf@xserver.flexserv.de> <200606161835.26428.s0348365@sms.ed.ac.uk>
 <87irn0zsqq.fsf@xserver.flexserv.de> <Pine.LNX.4.61.0606170005150.27136@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about:

SunVTS software



The SunVTS software executes multiple diagnostic hardware tests from a
single user interface, and is used to verify the configuration and
functionality of most hardware controllers and devices. The SunVTS 
software
operates primarily from a graphical user interface, enabling test 
parameters
to be set quickly and easily while a diagnostic test operation is being
performed.


http://docs.sun.com/source/817-7665/pmemtest.html

The pmemtest checks the physical memory of the system and reports hard and
soft error correction code (ECC) errors, memory read errors, and 
addressing problems. The pseudo driver mem is used to read the physical 
memory.


Note - 64-bit tests are located in the sparcv9 subdirectory:
/opt/SUNWvts/bin/sparcv9/testname, or the relative path to which you
installed SunVTS. If a test is not present in this directory, then it 
might
be available as a 32-bit test only. For more information, see 32-Bit and
64-Bit Tests



On Sat, 17 Jun 2006, Jan Engelhardt wrote:

>
>> Its an full equiped E420R 4*450Mhz 4GB RAM.
>> I dont know  a memtesttool for sparcs.
>
> Join the club, I am looking for one too.
>
> Too bad that the Forth interpreter can only address a little less than
> 640KB of memory (reminds me of DOS huh), otherwise I would have written a
> memchecker.
>
>> If you know one please drop me a line.
>> every test from obp runs fine.
>
> There exists a userspace checker. It mlock()s a big chunk of memory and
> pokes on it like memtest86. It does not catch the few megabytes required
> for booting, but when you swap the upper half of the memory banks with the
> lower ones and rerun, you should get the same results of memtest86 would
> do.
>
>
> Jan Engelhardt
> -- 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
