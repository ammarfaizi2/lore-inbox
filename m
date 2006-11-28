Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757961AbWK1MNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757961AbWK1MNw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 07:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758250AbWK1MNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 07:13:52 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:19175 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1757961AbWK1MNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 07:13:51 -0500
X-Sasl-enc: 6sP2HBuEQH6QDLMtVo+ILPsKp1BhheXWqkXb/5BFPeJE 1164716031
Date: Tue, 28 Nov 2006 10:13:46 -0200
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Ben Pfaff <blp@cs.stanford.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Entropy Pool Contents
Message-ID: <20061128121346.GB8499@khazad-dum.debian.net>
References: <ek2nva$vgk$1@sea.gmane.org> <456B4CD2.7090208@cfl.rr.com> <ekfifg$n41$1@taverner.cs.berkeley.edu> <EB3E5F09-6529-4AB9-B7EF-DFCACC6D445E@mac.com> <ekgd7u$6gp$1@taverner.cs.berkeley.edu> <878xhw5esn.fsf@blp.benpfaff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878xhw5esn.fsf@blp.benpfaff.org>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2006, Ben Pfaff wrote:
> daw@cs.berkeley.edu (David Wagner) writes:
> > Well, if you want to talk about really high-value keys like the scenarios
> > you mention, you probably shouldn't be using /dev/random, either; you
> > should be using a hardware security module with a built-in FIPS certified
> > hardware random number source.  
> 
> Is there such a thing?  "Annex C: Approved Random Number
> Generators for FIPS PUB 140-2, Security Requirements for
> Cryptographic Modules", or at least the version of it I was able
> to find with Google in a few seconds, simply states:
> 
>         There are no FIPS Approved nondeterministic random number
>         generators.

There used to exist a battery of tests for this, but a FIPS revision removed
them. You cannot really easily define a True RNG as secure or not with
simple tests.

I'd suggest googling after the papers validating the Intel and VIA Padlog
hardware RNGs, they are much better reading than FIPS for this.

If you want a software implementation of all the former FIPS tests, please
get the Debian fork of rng-tools, or Jeff's upstream rng-tools (Debian's has
a lot more stuff, but I don't recall if it has any extra FIPS
functionality).

I should get around to submit patches to Jeff one of these years.  It is
about a week-man-hours of tedious work, though.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
