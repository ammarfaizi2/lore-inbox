Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315943AbSEGSzf>; Tue, 7 May 2002 14:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315944AbSEGSzf>; Tue, 7 May 2002 14:55:35 -0400
Received: from khms.westfalen.de ([62.153.201.243]:52153 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S315943AbSEGSzd>; Tue, 7 May 2002 14:55:33 -0400
Date: 07 May 2002 20:29:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8OO85YGXw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.44.0205070944020.2509-100000@home.transmeta.com>
Subject: Re: [PATCH] 2.5.14 IDE 56
X-Mailer: CrossPoint v3.12d.kh9 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds)  wrote on 07.05.02 in <Pine.LNX.4.44.0205070944020.2509-100000@home.transmeta.com>:

> On Tue, 7 May 2002, Padraig Brady wrote:
> >
> > All the info I've ever needed is /proc/ide/hdx/capacity
> > which I could get from /proc/partitions with more a bit
> > more effort, so I vote for removing /proc/ide.
>
> Note that one thing that we might do is to leave the remnants of /proc/ide
> but _without_ the very verbose per-chipset reporting.
>
> At least to me it looks like it's all the chipset reporting that causes
> the huge kernel bloat, and it shouldn't be impossible to reinstate a
> minimal /proc/ide without those parts - while still keeping most of the
> backwards compatibility.

What I'd like to see - in whatever exact form - is the IDE equivalent to  
/proc/scsi/scsi. (And in fact, the SCSI version could use addition of at  
least the disk size and the sdX mapping.)

It's rather useful for getting a quick overview of what's on a system, and  
where.

Incidentally, is there a compelling reason why block device boot messages  
are all different?

> However, since I really don't much like the idea of having special
> "ide-only" /proc files, I personally think any information people actually
> used should be either in truly generic files (/proc/partitions as an
> example), _or_ they should be in the generic device tree (talk to Pat
> Mochel about that).

/proc/bus/ide or something like that? Sure, why not? Exact place is pretty  
much irrelevant except to legacy code.

MfG Kai
