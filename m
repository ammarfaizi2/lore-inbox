Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272068AbTHOWeo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 18:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272120AbTHOWeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 18:34:44 -0400
Received: from thunk.org ([140.239.227.29]:45983 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S272068AbTHOWen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 18:34:43 -0400
Date: Fri, 15 Aug 2003 18:34:02 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Val Henson <val@nmt.edu>
Cc: David Wagner <daw@mozart.cs.berkeley.edu>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030815223402.GB4306@think>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, Val Henson <val@nmt.edu>,
	David Wagner <daw@mozart.cs.berkeley.edu>,
	linux-kernel@vger.kernel.org
References: <20030809173329.GU31810@waste.org> <20030813032038.GA1244@think> <20030813040614.GP31810@waste.org> <20030814165320.GA2839@speare5-1-14> <bhgoj9$9ab$1@abraham.cs.berkeley.edu> <20030815001713.GD5333@speare5-1-14>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815001713.GD5333@speare5-1-14>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 06:17:13PM -0600, Val Henson wrote:
> There is no way in which folding is better than
> halving, and folding is demonstrably worse if SHA-1's output is
> correlated across the two halves in any way (which is almost certainly
> true).

If there any kind of correlation between any two individual bits, such
that XOR'ing them together resulted in a pattern which was not
statistically random, it would be a significant weakness in the SHA
algorithm.

Consider that a requirement of a secure cryptographic hash is one
where for any (x,y) pair where y=H(x), finding another x' where
y=H(x') is no easier than brute force search.  If two bits in the
output of the hash have any kind of statistically detectable
correlation, then it effectively reduces the size of the output space
of the hash, and so it would take less effort than a brute force
search of (on average) 2**80 random inputs before finding a hash
collision.

							- Ted
