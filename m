Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQLFS57>; Wed, 6 Dec 2000 13:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbQLFS5t>; Wed, 6 Dec 2000 13:57:49 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:46854 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129231AbQLFS5q>; Wed, 6 Dec 2000 13:57:46 -0500
Message-ID: <3A2E84E6.1F624FDC@transmeta.com>
Date: Wed, 06 Dec 2000 10:26:46 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kai Germaschewski <kai@thphy.uni-duesseldorf.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: That horrible hack from hell called A20
In-Reply-To: <Pine.LNX.3.95.1001206104447.26831A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> The protected-mode switch in INT 15 is probably the least tested BIOS
> function ever. I wouldn't trust it, and relying on it will put further
> burden on embedded Linux developers, many of whom don't even have a
> BIOS. It is 'least tested' because there is no way provided to get
> back to real-mode. This implies that somebody probably 'tested' it
> once, verified that some simple 32-bit function executed for a
> few microseconds, then declared; "It works!".
> 

And of course, that's pretty much all we'd trust it to do.  Personally,
I'd rather try to use the A20 gate function, if it works.  I suspect that
between the machines where the BIOS or the KBC works, we should be close
to 100% coverage.

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
