Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317431AbSHCD2f>; Fri, 2 Aug 2002 23:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317433AbSHCD2f>; Fri, 2 Aug 2002 23:28:35 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31240 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317431AbSHCD2e>; Fri, 2 Aug 2002 23:28:34 -0400
Date: Fri, 2 Aug 2002 20:32:10 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: <davidm@hpl.hp.com>
cc: Gerrit Huizenga <gh@us.ibm.com>, Hubertus Franke <frankeh@watson.ibm.com>,
       <Martin.Bligh@us.ibm.com>, <wli@holomorpy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: large page patch (fwd) (fwd) 
In-Reply-To: <15691.19423.265864.413887@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.33.0208022030170.2083-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Aug 2002, David Mosberger wrote:
> 
> The Rice people avoided some of the fragmentation problems by
> pro-actively allocating a max-order physical page, even when only a
> (small) virtual page was being mapped.

This probably works ok if
 - the superpages are only slightly smaller than the smaller page
 - superpages are a nice optimization.

>				  And since superpages quickly become
> counter-productive in tight-memory situations anyhow, this seems like
> a very reasonable approach.

Ehh.. The only people who are _really_ asking for the superpages want 
almost nothing _but_ superpages. They are willing to use 80% of all memory 
for just superpages.

Yes, it's Oracle etc, and the whole point for these users is to avoid 
having any OS memory allocation for these areas.

		Linus

