Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129355AbRB0BDt>; Mon, 26 Feb 2001 20:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129388AbRB0BDj>; Mon, 26 Feb 2001 20:03:39 -0500
Received: from eschelon.gamesquad.net ([216.115.239.45]:19716 "HELO
	eschelon.gamesquad.net") by vger.kernel.org with SMTP
	id <S129387AbRB0BDe>; Mon, 26 Feb 2001 20:03:34 -0500
From: "Vibol Hou" <vhou@khmer.cc>
To: "Andrew Morton" <andrewm@uow.edu.au>
Cc: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: RE: Sytem slowdown on 2.4.1-ac20 (recurring from 2.4.0)
Date: Mon, 26 Feb 2001 17:03:06 -0800
Message-ID: <NDBBKKONDOBLNCIOPCGHMEPAEPAA.vhou@khmer.cc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3A9AF846.A2A223D@uow.edu.au>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are you still getting the "hordes" of Tx timeouts with the
> 3c905B which you reported a week ago?

Yes, but they happen a few hours after the system starts up and continue
until the server is restarted.  It seems like a separate issue.  I haven't
tried taking down the interface and putting it back up since the interface
never dies link others have reported with their NICs.  The NIC continues to
work fine, though the logs get flooded with those messages.

> If so, do they only start coming out when the slowdown occurs?

That's a negative.

> You are probably a victim of the APIC bug.  A
> workaround for this is present in 2.4.2-ac5.  Alternatively,
> boot the kernel with the `noapic' LILO option.

I'll compile 2.4.2-ac5 and we'll see in another 5 days if this happens
again.  Till then, any suggestions on what to look for/at and/or what to do
when it happens will help.

Thanks!
--
Vibol Hou
KhmerConnection, http://khmer.cc

-----Original Message-----
From: morton@uow.edu.au [mailto:morton@uow.edu.au]On Behalf Of Andrew
Morton
Sent: Monday, February 26, 2001 4:44 PM
To: Vibol Hou
Cc: Linux-Kernel
Subject: Re: Sytem slowdown on 2.4.1-ac20 (recurring from 2.4.0)


Vibol Hou wrote:
>
> I've reported this problem a long while ago, but no one answered my pleas.
> To tell you the honest truth, I don't know where to begin looking.  It's
> difficult to poke around when the serial console is unresponsive :/
>

Sounds like a network driver problem.

Are you still getting the "hordes" of Tx timeouts with the
3c905B which you reported a week ago?

If so, do they only start coming out when the slowdown occurs?

You are probably a victim of the APIC bug.  A
workaround for this is present in 2.4.2-ac5.  Alternatively,
boot the kernel with the `noapic' LILO option.

Please let us know the outcome.

-

