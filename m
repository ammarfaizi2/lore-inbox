Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132357AbRAPTV0>; Tue, 16 Jan 2001 14:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132444AbRAPTVR>; Tue, 16 Jan 2001 14:21:17 -0500
Received: from lca0042.lss.emc.com ([168.159.120.42]:18839 "EHLO
	lca0042.lss.emc.com") by vger.kernel.org with ESMTP
	id <S132357AbRAPTVC>; Tue, 16 Jan 2001 14:21:02 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: problem mounting root under 2.4.0
In-Reply-To: <hp4ryzk42u.fsf@lca2240.lss.emc.com>
From: Chris Jones <clj@emc.com>
Date: 16 Jan 2001 14:20:22 -0500
In-Reply-To: Chris Jones's message of "16 Jan 2001 08:40:41 -0500"
Message-ID: <hpae8r2tjd.fsf@lca2240.lss.emc.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Jones <clj@emc.com> writes:

[...]

  I suspect the problem is related to loading the aic7xxx.o module, but the
  relevant messages have scrolled off the top of the screen.  I tried setting the
  VGA mode to extended to give me 50 lines of output, but even though "lilo -q
  -v" shows "VGA mode: EXTENDED", I still have a 25 line screen.

Well, I noticed I hadn't configured CONFIG_VIDEO_SELECT, which is why I wasn't
able to put my monitor into extended mode.  It now works, and I further noticed
I hadn't enabled RAM disk support, so my initial RAM disk wasn't being loaded.
So, 2.4.0 now boots (still with problems, probably caused by the modutils
changes, but at least I can debug now).

Thanks to the many people who emailed me with suggestions.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
