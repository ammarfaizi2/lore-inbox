Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267214AbUFZWSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267214AbUFZWSQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 18:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267213AbUFZWSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 18:18:16 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:8099 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S267216AbUFZWSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 18:18:12 -0400
Date: Sat, 26 Jun 2004 15:18:02 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       PARISC list <parisc-linux@lists.parisc-linux.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix the cpumask rewrite
Message-ID: <20040626221802.GA12296@taniwha.stupidest.org>
References: <1088266111.1943.15.camel@mulgrave> <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2004 at 09:32:15AM -0700, Linus Torvalds wrote:

> Now, I personally am not a big believer in the "volatile" keyword
> itself, since I believe that anybody who expects the compiler to
> generate different code for volatiles and non-volatiles is pretty
> much waiting for a bug to happen

I recently had to change jiffies_64 (include/linux/jiffies.h) to be
volatile as gcc produced code that didn't work as a result of it.

Clearly in some cases gcc does know about volatile and does produce
'the right thing' --- I don't really see why people claim volatile is
a bad thing, there are clearly places where we need this and gcc seems
to do the right thing.


  --cw

