Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVAANbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVAANbM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 08:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVAANbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 08:31:12 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:44556 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261874AbVAANbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 08:31:07 -0500
Date: Sat, 1 Jan 2005 14:39:00 +0100
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: "Peter T. Breuer" <ptb@lab.it.uc3m.es>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org, dm-crypt@saout.de
Subject: Re: PROBLEM: Kernel 2.6.10 crashing repeatedly and hard
Message-ID: <20050101133900.GA27446@hh.idb.hist.no>
References: <m3is6k4oeu.fsf@reason.gnu-hamburg> <m38y7fn4ay.fsf@reason.gnu-hamburg> <v3rda2-hjn.ln1@news.it.uc3m.es> <41D45C1F.5030307@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41D45C1F.5030307@tls.msk.ru>
User-Agent: Mutt/1.5.6+20040907i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2004 at 10:50:55PM +0300, Michael Tokarev wrote:
> Peter T. Breuer wrote:
> >In gmane.linux.raid Georg C. F. Greve <greve@fsfeurope.org> wrote:
> >
> >Yes, well, don't put the journal on the raid partition. Put it
> >elsewhere (anyway, journalling and raid do not mix, as write ordering
> >is not - deliberately - preserved in raid, as far as I can tell).
> 
> This is a sort of a nonsense, really.  Both claims, it seems.
> I can't say for sure whenever write ordering is preserved by
> raid -- it should, and if it isn't, it's a bug and should be
> fixed.  Nothing else is wrong with placing journal into raid
> (the same as the filesystem in question).  Suggesting to remove
> journal just isn't fair: the journal is here for a reason.
> And, finally, the kernel should not crash.  If something like
> this is unsupported, it should refuse to do so, instead of
> crashing randomly.

Write ordering trouble shouldn't crash the kernel, the way I
understand it.  Your journalled fs could be lost/inconsistent 
if the machine crashes for other reasons, due to bad write
ordering.  But the ordering trouble shouldn't cause a crash,
and all should be fine as soon as all the writes complete
without other incidents.

Helge Hafting
