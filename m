Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129857AbQK0Uad>; Mon, 27 Nov 2000 15:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129936AbQK0UaY>; Mon, 27 Nov 2000 15:30:24 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:57352 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S129857AbQK0UaK>; Mon, 27 Nov 2000 15:30:10 -0500
Message-ID: <3A22BD38.B5E0B3A7@transmeta.com>
Date: Mon, 27 Nov 2000 11:59:52 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11-pre5 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: KERNEL BUG: console not working in linux
In-Reply-To: <200011271952.eARJqqw514056@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" wrote:
> >
> > Yes, it can.  Unfortunately, some "legacy-free" PCs apparently
> > are starting to take the tack that the KBC is legacy.  Therefore,
> > the use of port 92h is mandatory on those systems.
> 
> Not just embedded systems?
> 

Nope.  I was rather surprised to find this out, but I got a bug report
about a recent IBM Aptiva not working with SYSLINUX because it lacked
KBC.  It really could use the adaptive-A20 patch; Linus hasn't taken it
yet, though. 

> > Port 92h dates back to at the very least the IBM PS/2.
> >
> > Either way, the video card of the original poster is broken in more
> > ways than that.  Ports 0x00-0xFF are reserved for the motherboard
> > chipset and have been since the original IBM PC.
> 
> His video card is the motherboard. He has built-in video.
> So the port is being used by his motherboard chipset.

I see.  Still an incredibly bad choice.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
