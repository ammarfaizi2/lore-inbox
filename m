Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129819AbRACTuO>; Wed, 3 Jan 2001 14:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130607AbRACTuE>; Wed, 3 Jan 2001 14:50:04 -0500
Received: from slc885.modem.xmission.com ([166.70.6.123]:39944 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129819AbRACTtq>; Wed, 3 Jan 2001 14:49:46 -0500
To: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
Cc: Gerold Jury <geroldj@grips.com>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>, <dl8bcu@gmx.net>,
        <Maik.Zumstrull@gmx.de>
Subject: Re: Happy new year^H^H^H^Hkernel..
In-Reply-To: <Pine.LNX.4.30.0101022348550.1202-100000@vaio>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Jan 2001 10:50:47 -0700
In-Reply-To: Kai Germaschewski's message of "Tue, 2 Jan 2001 23:55:45 +0100 (CET)"
Message-ID: <m17l4cjzig.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski <kai@thphy.uni-duesseldorf.de> writes:

> On Tue, 2 Jan 2001, Gerold Jury wrote:
> 
> > I have reversed the patches part by part, the only thing that makes a
> > difference is the diversion services.
> > The reason for this remains unknown for me.
> 
> I think I found it. Could everybody who was getting the crash on ISDN line
> hangup try if the following patch fixes the problem?
> 
> I think the problem was that we relied on divert_if being initialized to
> zero automatically, which didn't happen because it was not declared static
> and therefore not in .bss (*is this true?*).

All variables with static storage (not with static scope) if not explicitly
initialized are placed in the bss segment.  In particular this
means that adding/removing a static changes nothing.

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
