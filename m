Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314961AbSDVXoW>; Mon, 22 Apr 2002 19:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314962AbSDVXoV>; Mon, 22 Apr 2002 19:44:21 -0400
Received: from cabal.xs4all.nl ([213.84.101.140]:18611 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S314961AbSDVXoU>;
	Mon, 22 Apr 2002 19:44:20 -0400
Date: Tue, 23 Apr 2002 01:44:19 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: XFS in the main kernel
Message-ID: <20020422234419.GQ2470@wiggy.net>
Mail-Followup-To: Wichert Akkerman <wichert@wiggy.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <aa1f9o$519$1@picard.cistron.nl> <6047.1019518162@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Keith Owens wrote:
> dpkg uses mmap?

To read all its data files, just.

> There was a bug in XFS and mmapped files where incorrect blocks were
> flushed to disk under high load, but that was fixed around January 30.

That would produce corrupt files which does not seem to be the case.
If memory serves me corrrectly one of the problems was that rename(2)
returned an error in rare cases that should not be possible (might have
been ENOENT even though both we have verified in advance that can't be
true).

Wichert

-- 
  _________________________________________________________________
 /wichert@wiggy.net         This space intentionally left occupied \
| wichert@deephackmode.org            http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |
