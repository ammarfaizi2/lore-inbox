Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265132AbSKJTzP>; Sun, 10 Nov 2002 14:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265135AbSKJTzP>; Sun, 10 Nov 2002 14:55:15 -0500
Received: from zork.zork.net ([66.92.188.166]:36577 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S265132AbSKJTzO>;
	Sun, 10 Nov 2002 14:55:14 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Voyager subarchitecture for 2.5.46
References: <20021110191822.GA1237@elf.ucw.cz>
	<Pine.LNX.4.44.0211101127460.9581-100000@home.transmeta.com>
	<20021110194204.GF3068@atrey.karlin.mff.cuni.cz>
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: IGNORATIO ELENCHI, RANTING
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: : WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sun, 10 Nov 2002 20:02:00 +0000
In-Reply-To: <20021110194204.GF3068@atrey.karlin.mff.cuni.cz> (Pavel
 Machek's message of "Sun, 10 Nov 2002 20:42:04 +0100")
Message-ID: <6usmy99osn.fsf@zork.zork.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Pavel Machek quotation:

>> This is just a random sanity check thing, after all. It doesn't have to be 
>> system-global or even per-cpu. The only really important thing is that 
>> "gettimeofday()" should return monotonically increasing data - and if it 
                                  ^^^^^^^^^^^^^^^^^^^^^^^^
>> doesn't, the vsyscall would have to ask why (sometimes it's fine, if 
>> somebody did a settimeofday, but usually it's a sign of trouble).
>
> I believe you need it system-global. If task A tells task B "its
> 10:30:00" and than task B does gettimeofday and gets "10:29:59", it
> will be confused for sure.

Hence the requirement that it be monotonically increasing.

-- 
 /                          |
[|] Sean Neakums            |  Questions are a burden to others;
[|] <sneakums@zork.net>     |      answers a prison for oneself.
 \                          |
