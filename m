Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263927AbRFXJjo>; Sun, 24 Jun 2001 05:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263933AbRFXJjf>; Sun, 24 Jun 2001 05:39:35 -0400
Received: from smarty.smart.net ([207.176.80.102]:58116 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S263927AbRFXJjX>;
	Sun, 24 Jun 2001 05:39:23 -0400
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200106240950.FAA07005@smarty.smart.net>
Subject: The Joy of Forking
To: linux-kernel@vger.kernel.org
Date: Sun, 24 Jun 2001 05:50:20 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.5 is 26 meg now. It's time to consider forking the kernel. Alan has
already stuck his tippy-toe is that pool, and his toe is fine.

The "thou shalt not fork" commandment made sense at one point, when free
unix was a lost tribe wandering hungry in the desert. When you have a
project with several million users that has a scope that simply doesn't
scale, it doesn't. Forking should be done responsibly, and with great joy.
As in nature, software success breeds diversity. Linux should diversify.
This is cause for celebration, ceremony, throwing of bouquets and so on.

I have done a few trivial things that people with rather shallow ideas of
what unix is about have excoriated as "NOT UNIX!". So far that's been
absurd, but my stuff is getting more intrusive. Linux is far more
interesting to me for it's general usefulness and openness, which are
inextricably related, than for it's unixness, although unix is certainly
beautiful.

Alan was going to file for divorce over dev_t. Isn't is funny how
estranged couples so often are so much alike? dev_t is crucial, of course,
but it's not the biggest geological fault in the kernel. SMP is. I have
dropped hints about this before. An SMP system is more fundamentally
different than UP than a 386 is different than other big microprocessors.

As I mentioned that Steve Ballmer mentioned, Linux isn't getting any
traction on the client, the end-user desktop box. That's a huge and poorly
served market, so there are lots of tragically shallow ideas of how to
approach it. A few variations on the Linux theme are in order, that
preserve unixness, openness, but that don't have pretenses of being Big
UNIX(TM).

For a client-use Linux kernel, I suggest, and will be and have been
persuing, features and non-features such as...

	forget POSIX
		The standards that matter are de-facto standards. Linux is the
		standard. Congratulations. Take your seat in the chair for 
		First Violin. 
	rtlinux by default
	no SMP
		SMP doesn't scale. If this fork comes, the smart maintainer
		will take the non-SMP fork.
	x86 only (and similar, e.g. Crusoe)
	mimimal VM cacheing
		So you can red-switch the box without journalling with
		reasonable damage, which for an end-user is a file or two.
		Having done a lot of very wrong things with Linux, I'm 
		impressed that ext2 doesn't self-destruct under abuse.
	in-kernel interpreter
		I have one working. It's fun. 
	EOL is CR&LF
		The one thing Dos got right and unix got wrong. Also, in my
		2-month experience in a cube on a LAN, the most annoying thing
		about trying to be a Linux end-user in a Dos shop. Printers
		are CRLF, fer crissakes.
		This is not a difficult mod, but it's a lot of little changes
		throughout a box. Things that look for EOLs are the part that
		has to be fixed by hand, and can be inclusive of CRLF and LF.
	Plan 9-style header files structure
		Plan 9's most amazing stuff to me is the subtle refinements,
		like sane header files. Sane C header files, _oh_ _my_ _God_.  
	excellent localizability
		e.g. kernel error strings mapped to a file, or an #include
		that can be language-specific. My DSFH stuff also. 


What about GUI's, and "desktops" and such? They're nice. They are
secondary, however. The free unix world doesn't often enough make the
point that GUI's are much more important when the underlying OS sucks,
which it doesn't in Linux. 

In short, an open source OS for end-users should be very serious about
simplicity, and not just pay lip-service to it. There is evidence of the
value of this in the marketplace. What doesn't exist is an OS where
simplicity is systemic. This is why end-user issues pertain to the kernel
at all. This is how open source should be. Simple, or at least clear,
through and through. Linux has lost a lot of simplicity since I got into
it in '96, and that is a loss.

Rick Hohensee
www.clienux.com
