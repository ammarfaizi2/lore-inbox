Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031248AbWI0Xkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031248AbWI0Xkh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 19:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031251AbWI0Xkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 19:40:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12748 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1031248AbWI0Xkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 19:40:36 -0400
Date: Wed, 27 Sep 2006 16:31:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: eranian@hpl.hp.com
Cc: perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 perfmon new code base + libpfm + pfmon
Message-Id: <20060927163100.e83a1f79.akpm@osdl.org>
In-Reply-To: <20060927224832.GA17883@frankl.hpl.hp.com>
References: <20060926143420.GF14550@frankl.hpl.hp.com>
	<20060926220951.39bd344f.akpm@osdl.org>
	<20060927224832.GA17883@frankl.hpl.hp.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 15:48:32 -0700
Stephane Eranian <eranian@hpl.hp.com> wrote:

> Andrew,
> 
> Here is the summary of the various point raised by your review and the current
> status. I am hoping to close all points by next release.
> 
> ...
> 
> [akpm]: use fget_light() in some place instead of fget()
> 	- not sure understand when to use one versus the other
>

They are always interchangeable.  fget_light() is simply an optimised,
messier-to-use version.

>
> ..
>
> [akpm]: carta_random32() should be in another header file
> 	- yes, I know. Should I create a specific header file? I don't think random.h
> 	  is meant for this.

I suppose so.  Or just stick the declaration into kernel.h.

I had a patch go past the other day which had a hand-rolled
fast-but-not-very-good pseudo random number generator in it.  I couldn't
remember where I'd seen one, and now I can't remember what patch it was
that needed it.  Sigh.

Anyway, a standalone patch which adds that function into lib/whatever.c
would be nice.

