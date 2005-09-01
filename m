Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965054AbVIADLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbVIADLg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 23:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbVIADLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 23:11:36 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:36791 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S965054AbVIADLf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 23:11:35 -0400
Message-ID: <43167150.1040808@us.ibm.com>
Date: Wed, 31 Aug 2005 20:11:12 -0700
From: Ian Romanick <idr@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Allen Akin <akin@pobox.com>
CC: Discuss issues related to the xorg tree 
	<xorg@lists.freedesktop.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: State of Linux graphics
References: <9e47339105083009037c24f6de@mail.gmail.com> <1125422813.20488.43.camel@localhost> <20050831063355.GE27940@tuolumne.arden.org> <1125512970.4798.180.camel@evo.keithp.com> <20050831200641.GH27940@tuolumne.arden.org> <1125522414.4798.222.camel@evo.keithp.com> <20050901015859.GA11367@tuolumne.arden.org>
In-Reply-To: <20050901015859.GA11367@tuolumne.arden.org>
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=AC84030F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Allen Akin wrote:
> On Wed, Aug 31, 2005 at 02:06:54PM -0700, Keith Packard wrote:
> | 
> |         ...So far, 3D driver work has proceeded almost entirely on the
> | newest documented hardware that people could get. Going back and
> | spending months optimizing software 3D rendering code so that it works
> | as fast as software 2D code seems like a thankless task.
> 
> Jon's right about this:  If you can accelerate a given simple function
> (blending, say) for a 2D driver, you can accelerate that same function
> in a Mesa driver for a comparable amount of effort, and deliver a
> similar benefit to apps.  (More apps, in fact, since it helps
> OpenGL-based apps as well as Cairo-based apps.)

The difference is that there is a much larger number of state
combinations possible in OpenGL than in something stripped down for
"just 2D".  That can make it more difficult to know where to spend the
time tuning.  I've spent a fair amount of time looking at Mesa's texture
blending code, so I know this to be true.

The real route forward is to dig deeper into run-time code generation.
There are a large number of possible combinations, but they all look
pretty similar.  This is ideal for run-time code gen.  The problem is
that writing correct, tuned assembly for this stuff takes a pretty
experience developer, and writing correct, tuned code generation
routines takes an even more experienced developer.  Experienced and more
experienced developers are, alas, in short supply.

BTW, Alan, when are you going to start writing code again? >:)

> So long as people are encouraged by word and deed to spend their time on
> "2D" drivers, Mesa drivers will be further starved for resources and the
> belief that OpenGL has nothing to offer "2D" apps will become
> self-fulfilling.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFDFnFQX1gOwKyEAw8RAgZsAJ9MoKf+JTX4OGrybrhD+i2axstONgCghwih
/Bln/u55IJb3BMWBwVTA3sk=
=k086
-----END PGP SIGNATURE-----
