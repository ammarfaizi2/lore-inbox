Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131516AbQKJTzf>; Fri, 10 Nov 2000 14:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131593AbQKJTz0>; Fri, 10 Nov 2000 14:55:26 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:43023 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131516AbQKJTzO>; Fri, 10 Nov 2000 14:55:14 -0500
Message-ID: <3A0C5297.D039881@transmeta.com>
Date: Fri, 10 Nov 2000 11:55:03 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: davej@suse.de
CC: Brian Gerst <bgerst@didntduck.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: CPU detection revamp (Request for comments)]
In-Reply-To: <Pine.LNX.4.21.0011101937510.552-100000@neo.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@suse.de wrote:

> On Fri, 10 Nov 2000, Brian Gerst wrote:
> 
> > > features        : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow
> >
> > The K6's don't support sysenter/sysexit.
> 
> The K6 datasheets suggests otherwise.
> Some models seem to have sysenter/sysexit, whilst others have
> syscall/sysret. No model seems to have both.

Athlons have both.  Since the ext-bit 10 stuff is useless, I haven't
bothered reporting it at all.

> The datasheets are somewhat confusing, as it doesn't mention bit 10
> at all, just an oversized box for bit 11.
> 
> > It really should have been marked differently before.
> 
> Before we weren't mentioning it at all, look..
> flags  : fpu vme de pse tsc msr mce cx8 sep mtrr pge mmx 3dnow
> 
> > The early K6's used extended bit 10 to indicate syscall/sysret
> > capabality, but this version has some quirks that make it pretty much
> > unusable.  Later K6's use extended bit 11 to indicate syscall/sysret.
> 
> And where does sysenter/sysexit fit in?

sysenter/sysexit is the "sep" feature.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
