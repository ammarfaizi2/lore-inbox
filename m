Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311948AbSCTSzA>; Wed, 20 Mar 2002 13:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311946AbSCTSyu>; Wed, 20 Mar 2002 13:54:50 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:15365 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S311943AbSCTSye>;
	Wed, 20 Mar 2002 13:54:34 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Steven Walter <srwalter@yahoo.com>
Date: Wed, 20 Mar 2002 19:51:28 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.4.18 VIA MWQ patch (Athlon stomper) corrupts video wi
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <5D65D3668@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Mar 02 at 12:45, Steven Walter wrote:
> I have this problem, as well.  The fix for me was simply not to perform
> the fixup at all.  I'm not sure if clearing only bit 7 fixes the problem
> on my machine, but would grudgingly try it, if wanted.  (I don't have
> particularly ready access to the machine.)

You should find 'Disabling VIA memory write queue: [xx] aa->bb'
in your output. Values 'aa' and 'bb' are important - in other examples
it modifies value from 0x3x to 0x1x. Unfortunately I could not find
any hints whether we should clear bits 6,5 only on VIA_8363_0 if
revision is < 0x80, or whether we should not touch them at all.

In all reports from last september I remember that clearing bit 7 alone
fixed problems, but then patch which clears all three bits appeared
from VIA without real world examples which were affected by it...
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
