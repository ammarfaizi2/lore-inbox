Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266122AbSLOBz4>; Sat, 14 Dec 2002 20:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266128AbSLOBz4>; Sat, 14 Dec 2002 20:55:56 -0500
Received: from smtp08.iddeo.es ([62.81.186.18]:26328 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id <S266122AbSLOBzz>;
	Sat, 14 Dec 2002 20:55:55 -0500
Date: Sun, 15 Dec 2002 03:03:18 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: GrandMasterLee <masterlee@digitalroadkill.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021215020318.GC2265@werewolf.able.es>
References: <Pine.LNX.4.33.0212132319280.29293-100000@router.windsormachine.com> <Pine.LNX.4.33.0212132345040.12319-100000@router.windsormachine.com> <20021214100125.GA30545@suse.de> <1039890995.17062.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1039890995.17062.1.camel@localhost>; from masterlee@digitalroadkill.net on Sat, Dec 14, 2002 at 19:36:35 +0100
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.12.14 GrandMasterLee wrote:
>On Sat, 2002-12-14 at 04:01, Dave Jones wrote:
>> On Fri, Dec 13, 2002 at 11:53:51PM -0500, Mike Dresser wrote:
>>  > On Fri, 13 Dec 2002, Mike Dresser wrote:
>>  > 
>>  > > The single P4/2.53 in another machine can haul down in 3m17s
>>  > >
>>  > Amend that to 2m19s, forgot to kill a background backup that was moving
>>  > files around at about 20 meg a second.
>
>
>
>> Note that there are more factors at play than raw cpu speed in a
>> kernel compile. Your time here is slightly faster than my 2.8Ghz P4-HT for
>> example.  My guess is you have faster disk(s) than I do, as most of
>> the time mine seems to be waiting for something to do.
>
>An easy way to level the playing field would be to use /dev/shm to build
>your kernel in. That way it's all in memory. If you've got a maching
>with 512M, then it's easily accomplished.
>

tmpfs does not guarantee you that it is always in ram. It also can be paged.
An easier way is to fill you page cache with the kernel tree like

werewolf:/usr/src/linux# grep -v -r "" *

and then build, so no disk read will be trown.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-jam1 (gcc 3.2 (Mandrake Linux 9.1 3.2-4mdk))
