Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270767AbTHOUWo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 16:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270772AbTHOUWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 16:22:44 -0400
Received: from mailhost.NMT.EDU ([129.138.4.52]:29600 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id S270767AbTHOUWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 16:22:43 -0400
Date: Fri, 15 Aug 2003 14:22:35 -0600
From: Val Henson <val@nmt.edu>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: "David S. Miller" <davem@redhat.com>, daw@mozart.cs.berkeley.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030815202235.GB13384@speare5-1-14>
References: <20030809173329.GU31810@waste.org> <20030813032038.GA1244@think> <20030813040614.GP31810@waste.org> <20030814165320.GA2839@speare5-1-14> <bhgoj9$9ab$1@abraham.cs.berkeley.edu> <20030815001713.GD5333@speare5-1-14> <20030815093003.A2784@pclin040.win.tue.nl> <20030815004004.52f94f9a.davem@redhat.com> <20030815095503.C2784@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815095503.C2784@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
X-Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 09:55:03AM +0200, Andries Brouwer wrote:
> The lemma that you believe in, applied to x and z, says
> 
>  entropy(x) >= entropy(x xor z)
>  entropy(z) >= entropy(x xor z)
[snip]
> This "lemma", formulated in this generality, is just plain nonsense.

Indeed.  In the context of x = first 80 bits of SHA-1 hash, y = second
80 bits of SHA-1 hash, we are assuming that the entropy of x and y are
basically equal.  Then xoring them together gives us no benefit over
taking just one or the other, and may reduce the entropy if the output
of SHA-1 is correlated between the two halves in any way (which seems
more likely than not).

Including a little more context, then:

If entropy(x) == entropy(y), then:

entropy(x) >= entropy(x xor y)
entropy(y) >= entropy(x xor y)

Amusingly, someone already worked their way backwards from my post
without the benefit of any context to find that it implied that
entropy(x) == entropy(y).  I should know better than to assume that
people have read the entire thread before posting.

Apologies to Matt for sidetracking the discussion.  He has come up
with a nice solution despite our kibitzing.

-VAL
