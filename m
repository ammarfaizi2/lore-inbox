Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbSI3TBS>; Mon, 30 Sep 2002 15:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261289AbSI3TBS>; Mon, 30 Sep 2002 15:01:18 -0400
Received: from ns.splentec.com ([209.47.35.194]:37386 "EHLO pepsi.splentec.com")
	by vger.kernel.org with ESMTP id <S261283AbSI3TBN>;
	Mon, 30 Sep 2002 15:01:13 -0400
Message-ID: <3D98A0AA.9CEEAC40@splentec.com>
Date: Mon, 30 Sep 2002 15:06:18 -0400
From: Luben Tuikov <luben@splentec.com>
Organization: Splentec Ltd.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while 
 doingfiletransfers
References: <200209291545.g8TFj2v09855@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> 
> I run with the defaults (which are algorithm 0, Qerr 0).  However, what the
> drive thinks it's doing is not relevant to this discussion.  The question is
> "does the OS have any ordering expectations?".  The answer for Linux currently
> is "no".  In future, it may be "yes" and this whole area will have to be
> revisited, but for now it is "no" and no benefit is gained from being careful
> to preserve the ordering.
> 

Of course it will be ``yes'', it's just the next natural step for
an ever maturing (great!) OS. ``Ordering'' is implicitly preserved
in the buffer cache (read/write (2)), but DB/Journalled FS would
want a finer access to the device (imagination use req'd here).

And there's plenty of (old) research there on queuing models
which would provide that kind of flexibility for that future time
when there'd be ``oui'' :-).

> > I've already written one OpenSource SCSI mid-layer, given
> > presentations on how to fix the Linux mid-layer, and try to discuss
> > these issues with Linux developers.  I just don't have the energy to
> > go implement a real solution for Linux only to have it thrown away.
> > Life's too short.  8-)
> 
> What can I say? I've always found the life of an open source developer to be a
> pretty thankless, filled with bug reports, irate complaints about feature
> breakage and tossed code.  The worst I think is "This code looks fine now why
> don't you <insert feature requiring a complete re-write of proposed code>".
> 
> I can ceratinly sympathise with anyone not wanting to work in this
> environment.  I just don't see it changing soon.

Oh, c'mon James. You know we all appreciate you very much, no need for this.

The reason some of us have not started meddling with SCSI core is that
same appreciation of the other ppl working on it, the trust and good rapport.

Linux SCSI is one of the great environments, cf. <you know where'd I refer>.
I'm happy and proud to be part of this environment.

Probably what Justin meant is some past events in the history of Linux,
and the best course of action would be a LaTeX/PS/ASCII presentation/layout/blurb
of what Justin had in mind, and we can start from there.

-- 
Luben
