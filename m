Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315600AbSEIDV1>; Wed, 8 May 2002 23:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315601AbSEIDV0>; Wed, 8 May 2002 23:21:26 -0400
Received: from asooo.flowerfire.com ([63.254.226.247]:20964 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S315600AbSEIDVZ>; Wed, 8 May 2002 23:21:25 -0400
Date: Wed, 8 May 2002 22:21:20 -0500
From: Ken Brownfield <ken@irridia.com>
To: Dan Kegel <dank@kegel.com>
Cc: Anton Blanchard <anton@samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yossi@ixiacom.com" <yossi@ixiacom.com>
Subject: Re: khttpd newbie problem
Message-ID: <20020508222119.A12672@asooo.flowerfire.com>
In-Reply-To: <3CD402D2.E3A94CA2@kegel.com> <20020505005439.GA12430@krispykreme> <3CD4C93D.E543B188@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2002 at 10:55:09PM -0700, Dan Kegel wrote:
| Anton Blanchard wrote:
| > > I'm having an oops with khttpd on an embedded 2.4.17 ppc405
| > > system, so I thought I'd try it out on my pc.  But I can't
| > > get khttpd to serve any requests.
| > 
| > Any reason for not using tux? Its been tested heavily on ppc64,
| > the same patches should work on ppc32.
| 
| That's an excellent suggestion.  It certainly seems that khttpd
| is no longer production quality (if it ever was), and tux is.

khttpd is very much production quality on IA32, and has been since
2.4.0-test1.  TUX2 is not, however, since under load it enters a 99% CPU
busy loop.  You may not have enough load to cause TUX2 to do this, and
TUX1 may not have this problem.

| I'm on an embedded system, so if tux is much larger, I'll
| be annoyed; but the system does have 64 MB, so it's not *that*
| cramped.  And working is much better than crashing.

khttpd is extremely dependent on alignment and data sizes -- the
filename extension handling is deeply unfunny* for example.  khttpd most
likely has a problem with PPC (endian, etc).  Are you applying any other
patches that could conflict?
-- 
Ken.
ken@irridia.com

* phrase plagiarized from ac

| - Dan
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
