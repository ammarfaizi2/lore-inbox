Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313750AbSDPQGa>; Tue, 16 Apr 2002 12:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313746AbSDPQFj>; Tue, 16 Apr 2002 12:05:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49680 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313738AbSDPQEl>; Tue, 16 Apr 2002 12:04:41 -0400
Date: Tue, 16 Apr 2002 09:01:57 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Vojtech Pavlik <vojtech@suse.cz>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        David Lang <david.lang@digitalinsight.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 36
In-Reply-To: <E16xVcT-0000H9-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0204160857470.1244-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Apr 2002, Alan Cox wrote:
> > Please use a the network block device, and teach the ndb deamon to just
> > byteswap each word.
>
> You need to use loop not nbd - loopback nbd can deadlock. Byteswap as a
> new revolutionary crypto system for the loopback driver isnt hard

Even better - I did indeed miss the "security" aspect of the byteswapping
;)

And I know from personal experience that allowing partitioning of a
loopback thing would certainly have made some things a _lot_ easier (ie
not having to figure out the damn offsets in order to mount a filesystem
on a loopback volume), so having support for partitioning would be good.

Although I do have this suspicion that that partitioning support should be
in user space (along with all the rest of the partitioning support, but
that's another matter and has some rather more serious backwards
compatibility issues, of course. Is anybody still working on the new early
initrd?).

		Linus

