Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267445AbRGLHPM>; Thu, 12 Jul 2001 03:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267446AbRGLHPC>; Thu, 12 Jul 2001 03:15:02 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:36356 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S267445AbRGLHOz>; Thu, 12 Jul 2001 03:14:55 -0400
Date: 12 Jul 2001 09:23:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <84jaVrwXw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.33L.0107111913010.9899-100000@imladris.rielhome.conectiva>
Subject: Re: Switching Kernels without Rebooting?
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <Pine.LNX.4.33.0107112310590.962-100000@fogarty.jakma.org> <Pine.LNX.4.33L.0107111913010.9899-100000@imladris.rielhome.conectiva>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

riel@conectiva.com.br (Rik van Riel)  wrote on 11.07.01 in <Pine.LNX.4.33L.0107111913010.9899-100000@imladris.rielhome.conectiva>:

> One thing which always surprises me in this discussion
> (it comes up about once a year, it seems) is that
> nobody participating in this discussion ever starts
> writing any code for it.
>
> Is this a feature which is only wanted by people who
> don't want to code, or is this just a signal that the
> amount of trouble involved just isn't worth it?

Maybe it's a sign that the people who *would* be able to contribute have  
all looked at the problem already (surely most people are annoyed how a  
reboot interrupts everything), and have already concluded for themselves  
that it's not possible with reasonable effort ... but there is a steady  
influx of new people who don't understand enough of the problem and have  
to ask.

What I'd *really* like (but don't see how to get there) would be a "save  
system state, shutdown, change kernel and/or hardware, reboot, restore  
state" system (where state is like "I'm logged in on this console, in this  
current directory, and under X I have Netscape running and this page  
displayed" but I don't care about the exact state of Squid or even if my  
ISDN line is dialled in, because those "fix themselves").

I suspect to do this right would need a means of storing per-process state  
controlled by the process (because only that process knows what needs to  
be saved, and what can easily be reconstructed - for example, open file  
descriptors to a place where we store cookies don't need to be saved, just  
routinely reopened), and then every user-visible non-transient program  
needs to implement it - and I don't see *that* happen in the next ten  
years.

But it *does* have the advantage of not needing to save kernel-internal  
state.

MfG Kai
