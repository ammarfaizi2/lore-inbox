Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289036AbSA3KH1>; Wed, 30 Jan 2002 05:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289047AbSA3KHS>; Wed, 30 Jan 2002 05:07:18 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:42447 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S289036AbSA3KHK>;
	Wed, 30 Jan 2002 05:07:10 -0500
Date: Wed, 30 Jan 2002 05:07:08 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, lm@bitmover.com
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130050708.D11267@havoc.gtf.org>
In-Reply-To: <Pine.LNX.4.33.0201291641090.1747-100000@penguin.transmeta.com> <1012354692.1777.4.camel@stomata.megapathdsl.net> <20020130080504.JUTO18525.femail19.sdc1.sfba.home.com@there> <20020130034746.K32317@havoc.gtf.org> <a38ekv$1is$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <a38ekv$1is$1@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Jan 30, 2002 at 09:33:19AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 09:33:19AM +0000, Linus Torvalds wrote:
> I still dislike some things (those SHOUTING SCCS files) in bk, and let's
> be honest: I've used CVS, but I've never really used BK. Larry has given
> me the demos, and I actually decided to re-do the examples, but it takes
> time and effort to get used to new tools, and I'm a bit worried that
> I'll find other things to hate than just those loud filenames.

One issue I'm interested in, and Larry and I have chatted about this a
couple times, is making sure that the "standard" patch flow isn't
affected... and what I mean by that is out-of-order and/or modified
patches.

Say you apply patches A, B, and E from an Al Viro patch series,
reject D, and apply patch C but tweak it yourself [sb->s_id is case
in point IIRC].  Say further that Al sent you a BK patch.  (ha! but
bear with me :))  I want to be confident that BK does not cause
downstream patches to impose constraints on you which prevent or make
difficult weird cases like this, just to ensure that BK's idea of a
global tree remains intact.

Experience and additional BK knowledge on my part will likely clear this
up, but IIRC this was one of the larger issues with not only you but
many others concurrently developing on what I would call the "global
Linux tree."

Obviously this wouldn't apply if you fed BK patches into GNU patch, and
then issued the commit from there...  but that way is a bit lossy, since
you would need to recreate rename information among other things.

In any case, I think BK is pretty nifty so far, but want to practice
by importing all Linux patches into a tree before converting my own
"gkernel" cvs to BK.  (tytso disagrees and thinks that there should be a
separate BK tree for 2.4, 2.5,... IMHO: ug.)

	Jeff,
	who should really get sleep before tomorrow's LW-NY

