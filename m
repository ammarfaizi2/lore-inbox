Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130881AbQKGHRa>; Tue, 7 Nov 2000 02:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130462AbQKGHRN>; Tue, 7 Nov 2000 02:17:13 -0500
Received: from 64.124.41.10.napster.com ([64.124.41.10]:37646 "EHLO
	foobar.napster.com") by vger.kernel.org with ESMTP
	id <S130881AbQKGHQ7>; Tue, 7 Nov 2000 02:16:59 -0500
Message-ID: <3A07AC45.DCC961FF@napster.com>
Date: Mon, 06 Nov 2000 23:16:21 -0800
From: Jordan Mendelson <jordy@napster.com>
Organization: Napster, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: Poor TCP Performance 2.4.0-10 <-> Win98 SE PPP
In-Reply-To: <3A07662F.39D711AE@napster.com> <200011070428.UAA01710@pizda.ninka.net> <3A079127.47B2B14C@napster.com> <200011070533.VAA02179@pizda.ninka.net> <3A079D83.2B46A8FD@napster.com> <200011070603.WAA02292@pizda.ninka.net> <3A07A4B0.A7E9D62@napster.com> <200011070656.WAA02435@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    Date: Mon, 06 Nov 2000 22:44:00 -0800
>    From: Jordan Mendelson <jordy@napster.com>
> 
>    Attached to this message are dumps from the windows 98 machine using
>    windump and the linux 2.4.0-test10. Sorry the time stamps don't match
>    up.
> 
> (ie. Linux sends bytes 1:21 both the first time, and when it
>  retransmits that data.  However win98 "sees" this as 1:19 the first
>  time and 1:21 during the retransmit by Linux)
> 
> That is bogus.  Something is mangling the packets between the Linux
> machine and the win98 machine.  You mentioned something about
> bandwidth limiting at your upstream provider, any chance you can have
> them turn this bandwidth limiting device off?

It actually turns out that that problem with bandwidth was fixed
yesterday, so this can not be the problem here and yes, 64.124.41.179 is
a linux box. :)

> Or maybe earthlink is using some packet mangling device?
> 
> It is clear though, that something is messing with or corrupting the
> packets.  One thing you might try is turning off TCP header
> compression for the PPP link, does this make a difference?

Actually, there has been several reports that turning header compression
does help.


Jordan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
