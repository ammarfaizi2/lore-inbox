Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265700AbTABF5N>; Thu, 2 Jan 2003 00:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265705AbTABF5M>; Thu, 2 Jan 2003 00:57:12 -0500
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:50526 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S265700AbTABF5F>;
	Thu, 2 Jan 2003 00:57:05 -0500
From: <Hell.Surfers@cwctv.net>
To: billh@gnuppy.monkey.org, paul@clubi.ie, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org, rms@gnu.org
Date: Thu, 2 Jan 2003 06:04:21 +0000
Subject: RE:Re: Why is Nvidia given GPL'd code to use in closed source drivers?
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1041487461176"
Message-ID: <0a81b2500060213DTVMAIL4@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1041487461176
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

no winmodem equivalent. Ive backwards enginneered one of those...:-)

Dean McEwan, If the drugs don't work, [sarcasm] take more...[/sarcasm].

On Wed, 1 Jan 2003 21:58:59 -0800 Bill Huey (Hui) <billh@gnuppy.monkey.org> wrote:

--1041487461176
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from gnuppy.monkey.org ([68.15.8.100]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Thu, 2 Jan 2003 05:56:35 +0000
Received: from billh by gnuppy.monkey.org with local (Exim 3.36 #1 (Debian))
	id 18TyNf-00013M-00; Wed, 01 Jan 2003 21:58:59 -0800
Date: Wed, 1 Jan 2003 21:58:59 -0800
To: Paul Jakma <paul@clubi.ie>
Cc: Rik van Riel <riel@conectiva.com.br>, Hell.Surfers@cwctv.net,
	linux-kernel@vger.kernel.org, rms@gnu.org
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
Message-ID: <20030102055859.GA3991@gnuppy.monkey.org>
References: <20030102013736.GA2708@gnuppy.monkey.org> <Pine.LNX.4.44.0301020245080.8691-100000@fogarty.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301020245080.8691-100000@fogarty.jakma.org>
User-Agent: Mutt/1.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Return-Path: billh@gnuppy.monkey.org

On Thu, Jan 02, 2003 at 02:57:48AM +0000, Paul Jakma wrote:
> yes, but the legalities of it are rather grey.

It didn't seem that bad to me, it was all pretty abstracted outside of
their code. The glue layer to their object file is GPLed and therefore
public so that should be fine from what I can see.

> indeed, and if that were the only issue it would be clear there is no 
> issue. however, it must make use of linux code at runtime through 
> function calls - as linux makes use of the NVidia proprietary code by 
> calling the functions it provides.

Like what ? PCI IO poking functions ? Things that do mmap() trickery ?
That's pretty freaking basic. There wasn't anything terribly invasive
about the driver and source that I saw.

> Sometimes one has a choice between drivers written by the vendor and
> drivers written by (non-expert???) "community" authors, and often one
> finds the vendor driver is the one that isn't terribly optimised.

But this is computationally critical 3D. I mean, what kind of 3D vendor
would intentionally let something like that slide on x86 platforms ?

> > Matrix multiplies, T&L, etc...
> 
> none of this stuff is done in kernel (least it shouldnt be). Its done 
> in user-space libraries.

That stuff is done in hardware these days, not software. I mean, how would
anybody know what they're using. Why replicate that volume of functionality
when it already works well.

It simply doesn't make sense. I'm sure when decent AGP/DRM support is in
place they can start removing that stuff out of the Linux binary and
then make more of that publically available.

There motivations where to simply protect themselve by not releasing
proprietary code.

> The XFree licence allows binary only modules, indeed XFree 4 was 
> designed to make distribution of (possibly binary) modules as easy as 
> possible.
> 
> There isnt that much magic the NVidia kernel modules ought to be 
> doing really.

Notification of event completion from the (just guessing) who knows what
opcode operations the chip is doing, fast draw context switching, who knows.
These things are starting to look like FPU coprocessors, circa 1990, these
days.

Different hardware has differing needs. If it's pretty freaking exotic, then
let it to those folks handle it and the glue layer to userspace. It's not
like folks in GPL community write entire 3D frameworks for this casually.

High performance 3D is a Linux priority at this time. No real games or
heavy 3D apps that use crazy chips stuff...

> > communication between user and kernel space that provides this to
> > the OpenGL libraries are all exotic. I'm glad that nobody has to
> > deal with this stuff directly and that a vendor is willing to
> > provide support for it.
> 
> aha.. yes, all that complicated hardware stuff - you dont really want 
> those linux kernel amatuers writing that.

Well, having a generic kernel person, regardless of who they are, messing
with 3d chips and interfacing it with their OpenGL libs isn't a light topic.
This crap is heavy. So yes, its a good thing they've done this. What the
hell do you think this is ? an Ethernet driver ?

bill


--1041487461176--


