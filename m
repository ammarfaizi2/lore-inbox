Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271600AbRHZWjW>; Sun, 26 Aug 2001 18:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271560AbRHZWjM>; Sun, 26 Aug 2001 18:39:12 -0400
Received: from dialup-30064.dialup.ptt.ru ([195.34.30.64]:17157 "EHLO
	vegae.deep.net") by vger.kernel.org with ESMTP id <S271618AbRHZWjD>;
	Sun, 26 Aug 2001 18:39:03 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200109260301.f8Q31cq06972@vegae.deep.net>
Subject: Re: [OT] Howl of soul...
To: barryn@pobox.com
Date: Wed, 26 Sep 2001 03:01:38 +0000 (UTC)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  A low-level format (using IBM DFT) is going to *silently* remap bad
>  parts of the disk. It's only going to complain once it's no longer
>  possible to remap the bad sectors. So, just because the low-level format
>  doesn't complain does not mean that there is no media degradation!
    1. how to find problematic blocks?
           - just read, and if read fails goto 2.
	     (i.e. we found no new bad sectors)
	   - goto 2 on the sectors reported before as bad.
             (i.e. drive remembers sectors on which he had failures)
    2. what to do when i found problematic sector?
           - just see if it still usable.
         2a. i write to the sector, and after that i read crap.
               - sector is bad! should remap it!
         2b. i can write data to the sector, then reads goes ok.
               - hmm, i think that was kinda magnetetic storm, sector
 is still usable. do not remapping.

        in my case there was just magnetic storm, so the sector can be safely
     read/written again.

cheers,
Sam

