Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290804AbSARU3R>; Fri, 18 Jan 2002 15:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290805AbSARU3H>; Fri, 18 Jan 2002 15:29:07 -0500
Received: from mta9n.bluewin.ch ([195.186.1.215]:50680 "EHLO mta9n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S290804AbSARU3F>;
	Fri, 18 Jan 2002 15:29:05 -0500
Message-ID: <3C4884BB.6170979@bluewin.ch>
Date: Fri, 18 Jan 2002 21:25:31 +0100
From: Nicolas Aspert <Nicolas.Aspert@bluewin.ch>
Reply-To: Nicolas.Aspert@epfl.ch
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Didier Moens <moensd@xs4all.be>, linux-kernel@vger.kernel.org
Subject: Re: OOPS in APM 2.4.18-pre4 with i830MP agpgart
In-Reply-To: <E16RfZf-0007nk-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Unfortunately, loading agpgart yields an oops when APM ("apm -s") is
> > invoked, both in terminal and in X. APM functions perfectly when agpgart
> > is absent.
> 
> Looks like the author forgot to set the suspend/resume methods in the
> structure to the generic ones

Aargh... stupid me !! Well, I told Marcelo that I was not feeling too
good the day I submitted the patch :-) And  I just saw myself that the
netry was missing in the intel_820 stuff also (duh !)
The origin of the problem is that I happen to have an old kernel at home
(RH 7.1 2.4.2) that has no suspend/resume stuff, and this was where I
wrote the original patch, and the rest propagated through the usual
copy/paste way.
I correctly updated a part of the stuff but it's missing in other
places, and since I don't use APM, the problem did not show up. 
However, I am out of fast connection, so I am unable to make a patch
right now. 
If nobody has made it by monday, I'll send the patch

Best regards, and thanks Didier for pointing the problem (and Alan for
*very* quickly seeing what went wrong).
