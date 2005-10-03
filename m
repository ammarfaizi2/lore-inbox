Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932665AbVJCT5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932665AbVJCT5G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 15:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbVJCT5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 15:57:05 -0400
Received: from spirit.analogic.com ([204.178.40.4]:9232 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932665AbVJCT5E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 15:57:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <87zmpqbcws.fsf@amaterasu.srvr.nix>
References: <20051002094142.65022.qmail@web51012.mail.yahoo.com><35fb2e590510021153r254b7eb0haf9f9e365bed051e@mail.gmail.com><87oe66r62s.fsf@amaterasu.srvr.nix><20051003153515.GW7992@ftp.linux.org.uk> <87zmpqbcws.fsf@amaterasu.srvr.nix>
X-OriginalArrivalTime: 03 Oct 2005 19:56:59.0536 (UTC) FILETIME=[9D834100:01C5C854]
Content-class: urn:content-classes:message
Subject: Re: Why no XML in the Kernel?
Date: Mon, 3 Oct 2005 15:56:59 -0400
Message-ID: <Pine.LNX.4.61.0510031553030.25096@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Why no XML in the Kernel?
Thread-Index: AcXIVJ2M84t7l0PFSlS+hihrPMbR7w==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Nix" <nix@esperi.org.uk>
Cc: "Al Viro" <viro@ftp.linux.org.uk>, <jonathan@jonmasters.org>,
       "Ahmad Reza Cheraghi" <a_r_cheraghi@yahoo.com>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 3 Oct 2005, Nix wrote:

> On Mon, 3 Oct 2005, Al Viro moaned:
>> Another fun consideration in that area is that XML (or s-exp, or trees,
>> whatever representation you prefer) has nothing to help with dynamic data
>> structures.  Exporting snapshots does not work since the real state
>> includes the information about locks being held - without that you
>> can't tell which invariants hold at the moment, since the real ones
>> include lock state.
>
> Oh yes; the only practical way to get the system into a consistent state
> would be to take out the BKL (the old, non-preemptible variant),
> generate all that XML (for all of /proc and all of /sys!) and then
> release it again.
>
> Efficient this is *not*.
>
> (at least, not the loony everything-in-one-big-file variant. Keeping the
> current smaller files but making them XML is possible, but pointless:
> the filesystem already provides the hierarchical structure in /sys, and
> nothing can make /proc regular, so what's the point of adding an extra
> layer of hierarchy that serves only to complicate parsing and make it
> hard for *humans* to use?)
>
>>                      And forcing all locks involved into known state
>> is nowhere near feasible, of course.  OTOH, exporting dynamic state
>> including locks and walking the damn thing is
>> 	a) not feasible with XML
>
> It's feasible, if you don't mind ps(1) becoming a DoS attack, and one
> running instance of top(1) damn-nearly freezing the system.
>
> It's just not *sane*.
>
>> 	b) would require giving userland way too much access to locking,
>> creating a nightmare wrt deadlock potential.
>
> Indeed.
>
> (Current rant: DRM churn, forcing one of abandonment of decent 3D
> support, or upgrading of the X server to the bleeding-edge, or using an
> old kernel with known security holes, or becoming enough of a DRI
> developer to backport the changes, or using nothing but distro kernels
> <=2.6.11. Most of these are not terribly feasible for me right now. Ah
> well, my 3D card is total crap anyway. It's just a shame the X server
> crashes whenever asked to do in-software 3D rendering...  time to
> debug. I thought I might actually get some work done this evening. Fat
> chance.)
>

...could get rid of all the kernel function codes and just put a
XML interpreter inside the kernel. That way, web-page designers
could become kernel developers overnight.

> --
> `Next: FEMA neglects to take into account the possibility of
> fire in Old Balsawood Town (currently in its fifth year of drought
> and home of the General Grant Home for Compulsive Arsonists).'
>            --- James Nicoll
> -

XML inside the kernel is like BASIC inside the kernel. It
just doesn't belong there, even though it would work.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
