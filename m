Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267464AbTHOQMA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270142AbTHOQMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:12:00 -0400
Received: from zeus.kernel.org ([204.152.189.113]:59269 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S267464AbTHOQJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:09:00 -0400
Date: Fri, 15 Aug 2003 10:11:16 -0500
From: Matt Mackall <mpm@selenic.com>
To: M?ns Rullg?rd <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030815151116.GY325@waste.org>
References: <20030809173329.GU31810@waste.org> <20030813032038.GA1244@think> <20030813040614.GP31810@waste.org> <20030814165320.GA2839@speare5-1-14> <bhgoj9$9ab$1@abraham.cs.berkeley.edu> <20030815001713.GD5333@speare5-1-14> <20030815093003.A2784@pclin040.win.tue.nl> <20030815004004.52f94f9a.davem@redhat.com> <20030815095503.C2784@pclin040.win.tue.nl> <yw1xfzk3pcod.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xfzk3pcod.fsf@users.sourceforge.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 10:06:42AM +0200, M?ns Rullg?rd wrote:
> Andries Brouwer <aebr@win.tue.nl> writes:
> 
> >> > > entropy(x) >= entropy(x xor y)
> >> > > entropy(y) >= entropy(x xor y)
> >> > 
> >> > Is this trolling? Are you serious?
> >> 
> >> These lemma are absolutely true.
> >
> > David, did you read this line:
> >
> >> > Try to put z = x xor y and apply your insight to the strings x and z.
> >
> > Let us do it. Let z be an abbreviation for x xor y.
> >
> > The lemma that you believe in, applied to x and z, says
> >
> >  entropy(x) >= entropy(x xor z)
> >  entropy(z) >= entropy(x xor z)
> >
> > But x xor z equals y, so you believe for arbitrary strings x and y that
> >
> >  entropy(x) >= entropy(y)
> >  entropy(x xor y) >= entropy(y).
> >
> > This "lemma", formulated in this generality, is just plain nonsense.
> 
> Not quite non-sense, but it would mean that for any strings x and y, 
> 
>   entropy(x) == entropy(y),
> 
> which seems incorrect.

No, it's a premise stated at the beginning of the thread. We're
assuming perfect distribution for x and y. The problem here is that x
and y can be dependent or independent. If they're independent, then
there's no issue. If they're dependent (for instance correlated or
anticorrelated) then x^y biases toward zero or one. Which clearly has
less entropy.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
