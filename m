Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269285AbRGaMib>; Tue, 31 Jul 2001 08:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269286AbRGaMiW>; Tue, 31 Jul 2001 08:38:22 -0400
Received: from ns.caldera.de ([212.34.180.1]:64181 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S269285AbRGaMiL>;
	Tue, 31 Jul 2001 08:38:11 -0400
Date: Tue, 31 Jul 2001 14:37:08 +0200
From: Christoph Hellwig <hch@caldera.de>
To: Hans Reiser <reiser@namesys.com>
Cc: David Weinehall <tao@acc.umu.se>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org, Vitaly Fertman <vitaly@namesys.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption (patch to cause redhat to unmount reiserfs on halt included)
Message-ID: <20010731143708.A25442@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Hans Reiser <reiser@namesys.com>, David Weinehall <tao@acc.umu.se>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
	Vitaly Fertman <vitaly@namesys.com>,
	Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.33L.0107301858350.5582-100000@duckman.distro.conectiva> <3B65E0FE.CC84FF98@namesys.com> <20010731133443.N9244@khan.acc.umu.se> <3B66A305.E1A17E3A@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B66A305.E1A17E3A@namesys.com>; from reiser@namesys.com on Tue, Jul 31, 2001 at 04:22:29PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 31, 2001 at 04:22:29PM +0400, Hans Reiser wrote:
> I'll try simply ensuring that users are warned that debugging is on first.

Shouldn't the user be warned when mounting a reiserfs filesystem without
checking instead?

> Of
> course, with the way syslog is usually misconfigured on most distros we'll have
> to be careful to ensure that they ever see the messages....  Should I ask
> whether, with ReiserFS debugging on, and the default syslog.conf, the assertions
> being checked for on these particular distros ever reach the users?  Better I
> not ask....?

I think you got quite a few facts wrong:

  o when a kernel with non-modular reiserfs is booted, reitherfs is
    loaded before syslogd even starts
  o wether iy hits some logfile, the console or not usually depends on
    the KERN_ prefix you give to reiserfs
  o on Caldera the user won't see any kernel messages unless something
    unexpected happens or he explicitly wants it.

In either case one could rip that message out if there is any gain from it..

> If Chris wants to run ReiserFS with the checks on, fine, he is a user,

I am _not_ a reiserfs user.

> and he at
> least knows he is doing it, but when a distro does it without warning users the
> FS is crippled it is really foul.

I think you got that wrong.  It's really foul to not have checks in that
can prevent silent corruption on a filesystem that is not know for being
very stable.

> Well, if any of you users out there are interested in knowing practical details
> of how to overcome the shovelware,

There is no reason why you can't put a reiserfs_nocheck.o module on
your website.  If you want to I can send you a Caldera OpenLinux 3.1
package as reference.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
