Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161045AbWI1GuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161045AbWI1GuH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 02:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161047AbWI1GuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 02:50:05 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:41173 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1161045AbWI1GuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 02:50:02 -0400
Date: Wed, 27 Sep 2006 23:49:49 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 perfmon new code base + libpfm + pfmon
Message-ID: <20060928064949.GA18245@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20060926143420.GF14550@frankl.hpl.hp.com> <20060926220951.39bd344f.akpm@osdl.org> <20060927224832.GA17883@frankl.hpl.hp.com> <20060927163100.e83a1f79.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060927163100.e83a1f79.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On Wed, Sep 27, 2006 at 04:31:00PM -0700, Andrew Morton wrote:
> > 
> > Here is the summary of the various point raised by your review and the current
> > status. I am hoping to close all points by next release.
> > 
> > ...
> > 
> > [akpm]: use fget_light() in some place instead of fget()
> > 	- not sure understand when to use one versus the other
> >
> 
> They are always interchangeable.  fget_light() is simply an optimised,
> messier-to-use version.

What are exactly the assumptions of fget_light()?

> 
> >
> > ..
> >
> > [akpm]: carta_random32() should be in another header file
> > 	- yes, I know. Should I create a specific header file? I don't think random.h
> > 	  is meant for this.
> 
> I suppose so.  Or just stick the declaration into kernel.h.
> 
> I had a patch go past the other day which had a hand-rolled
> fast-but-not-very-good pseudo random number generator in it.  I couldn't
> remember where I'd seen one, and now I can't remember what patch it was
> that needed it.  Sigh.
> 
> Anyway, a standalone patch which adds that function into lib/whatever.c
> would be nice.

I will post a standalone patch for carta random. I can provide a standalone header
file in include/linux/carta_random.h. 

-- 
-Stephane
