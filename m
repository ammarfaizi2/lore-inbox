Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278087AbRJVIYp>; Mon, 22 Oct 2001 04:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278162AbRJVIYf>; Mon, 22 Oct 2001 04:24:35 -0400
Received: from tank.panorama.sth.ac.at ([193.170.53.11]:52748 "EHLO
	tank.panorama.sth.ac.at") by vger.kernel.org with ESMTP
	id <S278087AbRJVIYU>; Mon, 22 Oct 2001 04:24:20 -0400
Date: Mon, 22 Oct 2001 10:24:59 +0200
From: Peter Surda <shurdeek@panorama.sth.ac.at>
To: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Dri-devel] my X-Kernel question
Message-ID: <20011022102459.X12359@shurdeek.cb.ac.at>
In-Reply-To: <004901c15ab4$dbbb8fc0$5cbefea9@moya> <Pine.LNX.4.20.0110220224390.11846-100000@node2.localnet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JjNtGRvLZqzR8wa5"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.20.0110220224390.11846-100000@node2.localnet.net>; from volodya@mindspring.com on Mon, Oct 22, 2001 at 02:27:23AM -0400
X-Operating-System: Linux shurdeek 2.4.3-20mdk
X-Editor: VIM - Vi IMproved 6.0z ALPHA (2001 Mar 24, compiled Mar 26 2001 12:25:08)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JjNtGRvLZqzR8wa5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 22, 2001 at 02:27:23AM -0400, volodya@mindspring.com wrote:
> The biggest reason against this is that X (as it is now) support not only
> Linux but many other OSes: in particular BSD(s) and Solaris. Moving
> stuff into Linux kernel creates a fork of the drivers which is
> undesirable..
That's a lame excuse. I'm using Linux so I won't suffer from Windows, why
should I suffer because of BSD or Solaris?

<Rant>
About the precise vsync thingy we're talking about in xpert: we need kernel
support anyway. So why instead of calling a video driver in kernel "lame" and
"uncool" and adding a strange inflexible function god-knows-where, shouldn't
we move the whole driver structure to kernel? Drivers for every other device
type are in kernel. What would the anti-video-in-kernel-guys think if I
claimed that network cards should have userspace "drivers" in sort of "uber
daemon" and if an app wants to make a TCP connection it should contact this
"uber daemon"? I don't want to have staroffice in kernel, but the DRIVER
STRUCTURE. For a great UI, we need DMA, vsync and devices communicating with
each other directly or with little overhead. Why insist on doing this in
userspace? The reasons to put it into kernel aren't speed, but because it's
much more easier to add/maintain drivers, add functionality, share code and do
fancy stuff. DRI is a very good example of what I mean.
</Rant>

Short explaination of "the precise vsync thingy": For fluent video playback it
is necessary to precisely coordinate number of frames the monitor displays.
It is very visible on a TV. When I have a 25fps video, it should be EXACTLY
"one frame of data == one frame on TV". Currently, I can tell the card (ATI)
to blit on vsync (so it won't tear), but I can't tell it "don't miss a frame",
or "block until vsync". This results in visible "jumps" when suddenly the same
picture is staying on screen for the double duration than the others and it
sucks and I can't do anything about it without SOME kernel support. Telling
Xserver to poll for vsync and eat CPU is lame.

>                    Vladimir Dergachev
Bye,

Peter Surda (Shurdeek) <shurdeek@panorama.sth.ac.at>, ICQ 10236103, +436505122023

--
                   Disc space - The final frontier.

--JjNtGRvLZqzR8wa5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE709fbzogxsPZwLzcRAioqAJ4yegevqnCVWsBRLbR1O89NP4aUbACgjRMn
tmNMoH6SdKcYjERs99bWffw=
=lBuy
-----END PGP SIGNATURE-----

--JjNtGRvLZqzR8wa5--
