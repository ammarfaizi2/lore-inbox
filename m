Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130507AbRDBRIj>; Mon, 2 Apr 2001 13:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130834AbRDBRI3>; Mon, 2 Apr 2001 13:08:29 -0400
Received: from www.topmail.de ([212.255.16.226]:6549 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S130507AbRDBRIV> convert rfc822-to-8bit;
	Mon, 2 Apr 2001 13:08:21 -0400
Message-ID: <000201c0bb97$6c4e4ae0$de00a8c0@homeip.net>
From: "Thorsten Glaser Geuer" <eccesys@topmail.de>
To: "Boris Pisarcik" <boris@acheron.sk>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20010331230454.A801@Boris>
Subject: Basic Text Mode (was: Re: Question about SysRq)
Date: Mon, 2 Apr 2001 16:35:56 -0000
Organization: eccesys.net Linux development
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thought, i really love all sysrq properties of linux, so i need less often
> to make hardware resets an then await and fear, what fsck will print.

101% ACK

> One more property, that i'd like to have should be request key to force the
> most basic text mode (say 80x25) on the console, when eg. X freezes and 
> i kill its session, then last gfx mode resides on the screen and see no way 
> to restore back the text mode - /usr/bin/reset or something alike will not 
> do it. But it seems to be not a good idea at all, does it ? 

It is a very good idea, and to implement quite easy. You just do have to
diff between three types of video cards (MDA, MGA and HGC vs. CGA and AGA vs. EGA+).
Then you do direct register writes. For the HGC I did it recently in a DOS proggy
which switched from text to gfx and back. I had a TSR which simulated a gfx BIOS.
Only problem is, I lost the source. But I could rewrite and test it on request.
I even would put it under GPL for the kernel (normally this is a no-no for me),
just ask me. I will write it in NASM then because I can't the AT&T syntax.
For non-i386 Platforms I do not know about this topic. (IIRC the Apples didnt
even have a text mode)
Maybe I could look up the EGA register values somewhere.

-mirabilos


