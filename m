Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131975AbRA0IG6>; Sat, 27 Jan 2001 03:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131964AbRA0IGs>; Sat, 27 Jan 2001 03:06:48 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:14733 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S131975AbRA0IGe>;
	Sat, 27 Jan 2001 03:06:34 -0500
Message-ID: <3A72817E.CFCF0D52@pobox.com>
Date: Sat, 27 Jan 2001 00:06:22 -0800
From: J Sloan <jjs@pobox.com>
Organization: Mirai Consulting
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac11 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Aaron Lehmann <aaronl@vitelus.com>
CC: John Sheahan <john@reptechnic.com.au>, linux-kernel@vger.kernel.org
Subject: Re: ps hang in 241-pre10
In-Reply-To: <3A724FD2.3DEB44C@reptechnic.com.au> <20010126204324.B10046@vitelus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, It's official now, I didn't know if it was some
weird hardware fluke or something, but one of
the computers here exhibited the same problem -

The system in question is a Pentium II 400, scsi
only (aic7xxx), running 2.4.1-pre8 plus Andrew
Morton's low latency patches.

The user was playing unreal tournament at the time
and reported that it "got weird all of a sudden". I
logged in and tried to do a ps, but the ps froze
after listing a few lines. weird, never saw that one
before. The user rebooted, so there was further
opportunity to investigate, but I thought I ought
to mention it after seeing these reports!

jjs


Aaron Lehmann wrote:

> On Sat, Jan 27, 2001 at 03:34:26PM +1100, John Sheahan wrote:
> > Hi
> > my box has been running 2.4.1-pre10 for three days.
> > This morning I noticed odd behavioue - ps and top wouuld freeze
> > with no output.
>
> I had the same problem with 2.4.1-pre10 and the zerocopy patchset.
> I came home one day and xmms was frozen. Attempting to determine
> whether it was stuck in an odd state, I ran ps aux. At a certain
> point (presumably just when it started trying to print info about the
> xmms process), ps froze up too. And any attempts to killall -9 these
> processes made the killall freeze!
>
> I'm not sure what made xmms freeze up in the first place. My first
> though was a problem in the zerocopy patchset -- most of my mp3s are
> played over NFS. However, XMMS was completely idle during the time I
> was away from the computer, so I'm not sure what caused it. It seemed
> clear, however, that the problem was contagious between processes.
>
> I reverted back to 2.4.0-ac7 and have not had any more problems of this
> nature.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
