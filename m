Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266006AbRHFAmQ>; Sun, 5 Aug 2001 20:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266067AbRHFAmG>; Sun, 5 Aug 2001 20:42:06 -0400
Received: from alcove.wittsend.com ([130.205.0.20]:49805 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S266006AbRHFAlq>; Sun, 5 Aug 2001 20:41:46 -0400
Date: Sun, 5 Aug 2001 20:41:43 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: jakob@unthought.net, linux-kernel@vger.kernel.org
Subject: Re: /proc/<n>/maps getting _VERY_ long
Message-ID: <20010805204143.A18899@alcove.wittsend.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	jakob@unthought.net, linux-kernel@vger.kernel.org
In-Reply-To: <20010805171202.A20716@weta.f00f.org> <E15TNbk-0007pu-00@the-village.bc.nu> <20010806010738.B11372@unthought.net> <200108052341.f75Nfhx08227@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <200108052341.f75Nfhx08227@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Aug 05, 2001 at 04:41:43PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 05, 2001 at 04:41:43PM -0700, Linus Torvalds wrote:

	[...]

	I haven't been following this thread previously so I may be
way off base on this, but this caught my attention...

> So we certainly used to do more aggressive merging.

> We could merge more, but I'm not interested in working around broken
> applications. Right now we sanely merge the cases of consecutive
> anonymous mmaps, but we do _not_ merge cases where the app plays silly
> games, for example.

	Hmmm...  Apps that play silly games (intentionally) and
(deliberately) broken apps begin to fall into my territory.  Does
it become possible for a user application to create a system wide
denial of service by playing silly games or does this only affect
the application itself?  Yes, I know there are always ways of creating
denial of service attacks ala fork bombs and such, and I'm coming in on
this thread late, I'm just wondering about the scope of impact of "a
broken application" and does it give some leverage that can be
exploited by some misbehaving individual on a system?

> I'd like to know more than just the app that shows problems - I'd like
> to know what it is doing.

	Bruce Schneier put it best...  Fighting with broken applications
and classical "QA" and testing is programming for Murphy's computer.
Stuff goes bump in the night and broken apps cause bad things to happen.
In the security realm, we are programming for Satan's computer and have
to consider "apps that show problems" in the face of malicious intent.
What if what it is doing is trying to bring the system to its knees?

	If it only causes problems for the broken app, that's fine.  If it
causes problems for the rest of the system, that could be bad.

> 		Linus

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

