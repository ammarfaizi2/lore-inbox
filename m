Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267114AbSKXA7O>; Sat, 23 Nov 2002 19:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267115AbSKXA7O>; Sat, 23 Nov 2002 19:59:14 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:30479 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S267114AbSKXA7N>; Sat, 23 Nov 2002 19:59:13 -0500
Date: Sun, 24 Nov 2002 01:06:17 +0000
From: John Levon <levon@movementarian.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New module loader makes kernel debugging much harder
Message-ID: <20021124010617.GA58002@compsoc.man.ac.uk>
References: <20021123162346.GB30167@compsoc.man.ac.uk> <25340.1038098972@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25340.1038098972@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *18FlE2-000Fa3-00*JOtPhFb15Pk* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 24, 2002 at 11:49:32AM +1100, Keith Owens wrote:

> Even for module profiling, we need section data available.

I know, that's why I agreed with you...

> Although all module code currently goes in a single text area, there is
> no guarantee that will always be the case.  In the past we have had
> multiple text areas in modules (out of line lock code used its own
> section for a long time) and future changes could require multiple text
> sections.  To do profiling correctly, you need to know where all the
> text sections are, i.e. the module loader has to publish symbols and
> section data.  Loosing that data is a big step backwards.

Actually all *I* need is the address of one of the sections, as long as
they're simply mapped in we can work backwards given the sample file
and the offset of that section. So this already worked for when the
locking code was a separate section. But yeah, it would be helpful for
other uses to have more info available.

regards
john

-- 
Khendon's Law: If the same point is made twice by the same person,
the thread is over.
