Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273658AbRI0QRg>; Thu, 27 Sep 2001 12:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273661AbRI0QR0>; Thu, 27 Sep 2001 12:17:26 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:46342 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S273658AbRI0QRT>; Thu, 27 Sep 2001 12:17:19 -0400
Date: Thu, 27 Sep 2001 12:17:46 -0400
Message-Id: <200109271617.f8RGHkH08397@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
X-Also-Posted-To: linux.dev.kernel
Subject: Re: [PATCH] core file naming option
In-Reply-To: <3BB104A9.3AD512A5@inet.com>
Distribution: local
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Reply-To: davidsen@tmr.com (bill davidsen)
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BB104A9.3AD512A5@inet.com>,
Eli Carter <eli.carter@inet.com> wrote:

| The attached patch adds an option to the build to have core files named
| core.processname, but defaulting to the current behaviour of course. 
| For most people the single 'core' file is sufficient, but when the sky
| is falling, it's nice to have more places for it to land.  :)
| So, is this something that might go into the kernel, or are their
| philisophical reasons against it?  (The patch is against 2.2.19.  I
| haven't looked at 2.4.x yet.  Let me know if you want a 2.4 or if I
| should send it to Linus, or...)
| 
| Questions, comments, etc. welcome,

  Since you asked for it... ;-)

  While you're adding this feature, and it seems others are adding
similar things, it is *highly* desirable to allow the build to put all
the dumps in one place of desired (my  first thought is /var/core) so
that if you get a lot you won't run the system out of disk.

  The directory name could be set in /proc/sys/coredir (or somesuch)
with an initial value of "." of course.

  Other than that I like the idea, although process "name" could get a
lot of clashes on threads, and pid gets reused. There may be a better
idea, but most of mine are cumbersome. This would really simplify
certain kinds of dump analysis.

-- 
bill davidsen <davidsen@tmr.com>
 "If I were a diplomat, in the best case I'd go hungry.  In the worst
  case, people would die."
		-- Robert Lipe
