Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQLAO6a>; Fri, 1 Dec 2000 09:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbQLAO6T>; Fri, 1 Dec 2000 09:58:19 -0500
Received: from windsormachine.com ([206.48.122.28]:36881 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S129210AbQLAO6B>; Fri, 1 Dec 2000 09:58:01 -0500
Message-ID: <3A27B544.A1C76304@windsormachine.com>
Date: Fri, 01 Dec 2000 09:27:16 -0500
From: Mike Dresser <mdresser@windsormachine.com>
Organization: Windsor Machine & Stamping
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Guennadi Liakhovetski <gvlyakh@mail.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: DMA for triton again...
In-Reply-To: <E141WqR-000AxY-00@f3.mail.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    You're going to get a chuckle out of this one, i think.  I was using my main fileserver at home(different box from
the ones we're talking about)last night, and figured i'd poke around, do some speed benchmarks for the hell of it.  At
one point months, i had everything running in DMA mode, drives are doing 20ish meg a second transfers.  Had to replace
my EDO 128 meg dimm with a 32 meg SDRAM stick, because quite frankly, EDO dimms suck at 100fsb. :P  So anyways, i
check, and lo and behold, my system is running all the drives in non-DMA mode.  THE HORROR!  I was wondering why the
network sucked :)  So i do some poking around.. Dumped the IDE patches, didn't make a difference.  Put the ide patches
back in, started playing in the bios.  Finally fixed it.  I was getting the same operation not permitted, that you
were,until i got that bios setting.  My mission tonight will be to find which one it was =)  The weird part is that
this is a 591 Apollo Pro chipset, not the FX.  But it's making me wonder if it's something similar in your bios!
I know it wasn't the actual UDMA setting in the bios, i'm wondering what it was though.  I'll put a keyboard on it,
and poke around tonight or this weekend.


Guennadi Liakhovetski wrote:

> > I'll see how mangled my .config is.
> > Looks somewhat clean, a few modules i don't use.  I'll send it in a > seperate email.
>
> Thanks a lot, Mike! I can see couple of differences already, will try tonight... and will let you know tomorrow...
>
> Cheers
> Guennadi
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
