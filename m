Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283783AbSAEVAX>; Sat, 5 Jan 2002 16:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283786AbSAEVAN>; Sat, 5 Jan 2002 16:00:13 -0500
Received: from mail.vr-web.de ([195.243.197.42]:45840 "HELO mail.VR-Web.de")
	by vger.kernel.org with SMTP id <S283783AbSAEVAB>;
	Sat, 5 Jan 2002 16:00:01 -0500
Date: Sat, 5 Jan 2002 21:53:03 +0100 (CET)
From: Matthias Hanisch <mjh@vr-web.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: davidel@xmailserver.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre performance degradation on an old 486 (it's the
 scheduler)
In-Reply-To: <200201051516.QAA20961@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.10.10201052140290.280-100000@pingu.franken.de>
Organization: Matze at his stone-old Linux Box
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jan 2002, Mikael Pettersson wrote:

> BINGO! Running 2.5.2-pre8 with the scheduler changes backed out made
> all the difference! Interactive responsiveness is much improved and
> performance in the above two tests I ran is back to 2.4.18pre1 levels.
> 
> With 2.5.2-pre8 vanilla the 486 is getting large variation in Test 2
> above (157s, 237s, 292s), but is never even close to 2.2/2.4 levels.

This means, it's the same problem.

I also tried the elevator fixes from Peter Osterlund posted in LKML
yesterday, which did not change anything for me. So it really seems, that
the culprit is the scheduler.

I'm not an expert in that area, so I am a little bit stuck right now. If
anybody has an suggestion, what we can investigate next (like backing out
only parts of the scheduler patch or place some strategic printf's), I am
willing to try this on my machine.

By the way, I also tried Ingo's scheduler yesterday, which at least didn't
show up with these problems. It even survived some hours of stress
testing.

Regards,
	Matze



