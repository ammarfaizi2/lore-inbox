Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265574AbUFTPm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265574AbUFTPm0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 11:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265590AbUFTPm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 11:42:26 -0400
Received: from ultra12.almamedia.fi ([193.209.83.38]:35021 "EHLO
	ultra12.almamedia.fi") by vger.kernel.org with ESMTP
	id S265574AbUFTPmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 11:42:20 -0400
Message-ID: <40D5B0B7.CA20C30A@users.sourceforge.net>
Date: Sun, 20 Jun 2004 18:43:51 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, 4Front Technologies <dev@opensound.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Stop the Linux kernel madness
References: <40D232AD.4020708@opensound.com> <3217460000.1087518092@flay>
		 <40D23701.1030302@opensound.com> <20040618204655.GA4441@mars.ravnborg.org>
		 <40D46B97.B82A439E@users.sourceforge.net> <Pine.LNX.4.58.0406191952520.10292@scrub.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> On Sat, 19 Jun 2004, Jari Ruusu wrote:
> > SUSE folks made a silly mistake and broke stuff. It was even more silly for
> > them to try to submit that breakage to mainline.
> 
> Letting the symlink point to the build directory is the only sane option.

No. That breaks stuff. Only sane solution IMO is to leave the
/lib/modules/`uname -r`/build symlink alone, and add another
/lib/modules/`uname -r`/object symlink that points to the object tree.

> What's missing is that the native kernel tree itself should generate a
> small Makefile in the build directory.
> SuSE did the right thing, it now just needs proper integration.

Separate source and object tree feature has been in mainline for at least
half a year. Linus has released 8 stable kernels in the 2.6 line of kernels.
Distros have released uncounted number of kernels based on those 2.6
kernels. All of those kernels, except latest SUSE damaged ones, have the
/lib/modules/`uname -r`/build symlink pointing to source tree if they are
compiled to use separate object tree.

My point is that this separate source and object trees thingy is not
anything new, even though some SUSE people seem to think so. If SUSE people
choose to break their kernels, it is their problem and their customers'
problem. I don't see any reason why mainline should be broken just because
SUSE people chose break their kernels.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
