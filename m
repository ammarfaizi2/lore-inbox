Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317232AbSGHWz4>; Mon, 8 Jul 2002 18:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317251AbSGHWzz>; Mon, 8 Jul 2002 18:55:55 -0400
Received: from jalon.able.es ([212.97.163.2]:46492 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S317232AbSGHWzy>;
	Mon, 8 Jul 2002 18:55:54 -0400
Date: Tue, 9 Jul 2002 00:58:16 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: Austin Gonyou <austin@digitalroadkill.net>, linux-kernel@vger.kernel.org
Subject: Re: Terrible VM in 2.4.11+?
Message-ID: <20020708225816.GA1948@werewolf.able.es>
References: <20020709001137.A1745@mail.muni.cz> <1026167822.16937.5.camel@UberGeek> <20020709005025.B1745@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020709005025.B1745@mail.muni.cz>; from xhejtman@mail.muni.cz on Tue, Jul 09, 2002 at 00:50:25 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.07.09 Lukas Hejtmanek wrote:
>
>Yes, I know a few people that reports it works well for them. How ever for me
>and some other do not. System is redhat 7.2, ASUS A7V MB, /dev/hda is on promise
>controller. Following helps a lot:
>
>while true; do sync; sleep 3; done
>
>How did you modify the params of bdflush? I do not want to suspend i/o buffers 
>nor disk cache.. 
>
>Another thing to notice, the X server has almost every time some pages swaped to
>the swap space on /dev/hda. When bdflushd is flushing buffers X server stops as
>has no access to the swap area during i/o lock.
>
>On Mon, Jul 08, 2002 at 05:37:02PM -0500, Austin Gonyou wrote:
>> I do things like this regularly, and have been using kernels 2.4.10+ on
>> many types of boxen, but have yet to see this behavior. I've done this
>> same type of test with 16k blocks up to 10M, and not had this problem I
>> usually do test with regard to I/O on SCSI, but have tested on IDE,
>> since we use many IDE systems for developers. I found though, that using
>> something like LVM, and overwhelming it, causes bdflush to go crazy. I
>> can hit the wall you refer to then.When bdflushd is too busy...it does
>> in fact seem to *lock* the system, but of course..it's just bdflush
>> doing it's thing. If I modify the bdflush params..this causes things to
>> work just fine, at least, useable.
>

Seriously, if you have that kind of problems, take the -aa kernel and use it.
I use it regularly and it behaves as one would expect, and fast.
And please, report your results...

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-rc1-jam1, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.7mdk)
