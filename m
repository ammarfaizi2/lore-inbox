Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261972AbREURwt>; Mon, 21 May 2001 13:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261973AbREURwj>; Mon, 21 May 2001 13:52:39 -0400
Received: from tahoe.in-system.com ([207.70.22.1]:33036 "EHLO
	tahoe.in-system.com") by vger.kernel.org with ESMTP
	id <S261972AbREURw3>; Mon, 21 May 2001 13:52:29 -0400
Message-Id: <200105211752.LAA12353@osprey.in-system.com>
Date: Mon, 21 May 2001 11:52:18 -0600 (MDT)
From: Jim Castleberry <jcastle@in-system.com>
Reply-To: Jim Castleberry <jcastle@in-system.com>
Subject: Re: "clock timer configuration lost" on Serverworks chipset
To: jcastle@in-system.com, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: vdO8uWKxQGGwE/bCdsgYGg==
X-Mailer: dtmail 1.3.0 @(#)CDE Version 1.4 SunOS 5.8 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm confused.  The 2.2.19 time.c is already doing ">":
    /* VIA686a test code... reset the latch if count > max */
    if (count > LATCH-1) {
        [adjust count and whine]
The 2.2.20-pre2 patch doesn't change time.c, and I don't see
this code in 2.4.4 or 2.4.5pre.

Are you saying the code should be doing the equivalent of
"(count > LATCH)", or is 2.2.19 correct and the whines I'm
seeing mean there really is a problem with the Serverworks
chipset?

Thanks,

jcastle

Alan Cox wrote:
>Jim Castleberry)wrote:
>> How well has the problem been nailed down?  Could it be that it just
>> showed up first on VIA and the real cause (and fix) remains to be
>> discovered?  Or does Serverworks somehow have an identical bug in
>> their chipset?
>
>There is a notional off by one in the check at least by the rules of the
>original chip which do allow the overflow value to be visible momentarily.
>Later -ac checks for > not >=
>

