Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263117AbSJBOrY>; Wed, 2 Oct 2002 10:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263119AbSJBOrY>; Wed, 2 Oct 2002 10:47:24 -0400
Received: from gate.in-addr.de ([212.8.193.158]:20232 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S263117AbSJBOrX>;
	Wed, 2 Oct 2002 10:47:23 -0400
Date: Wed, 2 Oct 2002 16:54:35 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove LVM from 2.5 (resend)
Message-ID: <20021002145434.GA1202@marowsky-bree.de>
References: <Pine.GSO.4.21.0210011010380.4135-100000@weyl.math.psu.edu> <Pine.LNX.4.43.0210011650490.12465-100000@cibs9.sns.it> <20021001154808.GD126@suse.de> <20021001184225.GC29788@marowsky-bree.de> <1033520458.20284.46.camel@irongate.swansea.linux.org.uk> <20021002042434.GA13971@think.thunk.org> <1033565669.23682.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1033565669.23682.10.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-10-02T14:34:29,
   Alan Cox <alan@lxorguk.ukuu.org.uk> said:

> > completely bypassing its core infrastructure (since you're no longer
> > just doing simple block remapping at that point), and once you add all
> > that stuff, it's likely to become much more complex.
> Last time I checked we already had a perfectly good md driver for the
> raid5 handling

Not entirely. I gather that EVMS AIX RAID code has some very nice properties
like journaling (which of course cannot be mapped directly onto md), greatly
speeding up rebuilds after a crash.

The MD code will also show some very nice failure scenarios in a clustered
software-RAID scenario, which the EVMS code could (from what I know) address.
(Whether that's a sensible scenario or not is left as an exercise to the
reader...)

I'll also admit that the "EVMS on top of DM and rip out everything else" was
slightly over the top on purpose, though I'd be somewhat annoyed if we had
EVMS (with its compatibility modules) and the modules it is supposed to be
compatible with (ie, md) at the same time, with duplicated code. That would
suck. Unless of course it was indeed meant as a transition period.

I'd be fine if someone said "We'll have EVMS, md and DM in 2.6 and then sort
the mess in 2.7.", I'm just curious what the goal is. Right now, there's no
working code in 2.5 nor a vision, which is obviously a major bug.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Principal Squirrel
Research and Development, SuSE Linux AG
 
``Immortality is an adequate definition of high availability for me.''
	--- Gregory F. Pfister

