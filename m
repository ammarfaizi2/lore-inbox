Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWEYAIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWEYAIu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 20:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWEYAIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 20:08:50 -0400
Received: from thunk.org ([69.25.196.29]:44195 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932313AbWEYAIt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 20:08:49 -0400
Date: Wed, 24 May 2006 20:08:29 -0400
From: Theodore Tso <tytso@mit.edu>
To: Marcin Dalecki <dalecki.marcin@neostrada.pl>
Cc: Matt Mackall <mpm@selenic.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       davem@davemloft.net
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Message-ID: <20060525000829.GA24897@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Marcin Dalecki <dalecki.marcin@neostrada.pl>,
	Matt Mackall <mpm@selenic.com>, Kyle Moffett <mrmacman_g4@mac.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	davem@davemloft.net
References: <8.420169009@selenic.com> <65CF7F44-0452-4E94-8FC1-03B024BCCAE7@mac.com> <20060505172424.GV15445@waste.org> <20060505191127.GA16076@thunk.org> <20060505203436.GW15445@waste.org> <20060506115502.GB18880@thunk.org> <20060506164808.GY15445@waste.org> <20060506180551.GB22474@thunk.org> <6935C0D2-528C-47B5-A7A8-7FCA2672FCD7@neostrada.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6935C0D2-528C-47B5-A7A8-7FCA2672FCD7@neostrada.pl>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 12:47:18AM +0200, Marcin Dalecki wrote:
> Anytime you start to make unquantified assumptions in the context of
> / dev/random the issue turns up that this whole thing is not worth
> the trouble because much simpler approaches will be sufficient
> enough to acomplish what it does. On the other hand you can't
> provide any actual full analysis of it's behaviour - which is just
> *not acceptable* for anybody trully concerned. And this in
> conjunction makes the WHOLE idea behind it questionable.

Nobody can provide any kind of full analysis about whether or not
SHA-2 or AES is secure, either.  Does that we mean we just give up and
go home?  No, we do the best job we can, with the best information we
have.  Sometimes that means we have to make assumptions, but the
entire construction of AES and SHA-2 is based on similar assumptions,
too.

Academics who make "full analysis" generally use as axioms things like
"assume MD5 is secure" or "assume SHA-1 is secure", which are really
fancy assumptions.  If we had used a "simpler approaches" based such
axioms we might have been in trouble.  So I think some of the analysis
and designs choices that I made in /dev/random is most definitely
worth the trouble.

Regards,

						- Ted
