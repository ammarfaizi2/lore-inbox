Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275010AbRIYOES>; Tue, 25 Sep 2001 10:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275011AbRIYOEI>; Tue, 25 Sep 2001 10:04:08 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:10502 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S275010AbRIYOD6>; Tue, 25 Sep 2001 10:03:58 -0400
Date: Tue, 25 Sep 2001 10:04:24 -0400
Message-Id: <200109251404.f8PE4Oh06427@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
X-Newsgroups: linux.dev.kernel
In-Reply-To: <20010924185755.E4126@schmorp.de>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Reply-To: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010924185755.E4126@schmorp.de> Marc Lehmann wrote:
| On Mon, Sep 24, 2001 at 06:53:03PM +0200, Matthias Andree
| <matthias.andree@stud.uni-dortmund.de> wrote:
| > Linear writing as dd mostly does is BTW something which should never be
| > affected by write caches.
| 
| A write cache can and will speed up linear writes on typical ide setups.

Pedantically I guess that's true, but I wouldn't expect any significant
change unless the drive were badly fragmented, since the write cache on
the drive should hold enough data to allow all data to a track to be
written in a single revolution.

Write cache makes a big difference in normal use, where seeks and such
can be optimized, but for a single process writing a single file (ie.
dd) I don't see where it would or could help much.

Since the single process is not a typical case on most systems, I don't
see that it's a burning question.

-- 
bill davidsen <davidsen@tmr.com>
 "If I were a diplomat, in the best case I'd go hungry.  In the worst
  case, people would die."
		-- Robert Lipe
