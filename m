Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbTJAOmr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 10:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbTJAOmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 10:42:47 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:59801 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262062AbTJAOmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 10:42:39 -0400
Date: Wed, 1 Oct 2003 16:42:23 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Valdis.Kletnieks@vt.edu
Cc: Dave Jones <davej@redhat.com>, Matthew Wilcox <willy@debian.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_* In Comments Considered Harmful
Message-ID: <20031001144223.GJ31698@wohnheim.fh-wedel.de>
References: <20031001132619.GL24824@parcelfarce.linux.theplanet.co.uk> <20031001141950.GA13115@redhat.com> <200310011429.h91ETtcG009923@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200310011429.h91ETtcG009923@turing-police.cc.vt.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 October 2003 10:29:55 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 01 Oct 2003 15:19:52 BST, Dave Jones said:
> 
> > Maybe it should be taught to parse comments? There are zillions of
> > #endif /* CONFIG_FOO */
> > braces in the tree. Why is this one special ?
> 
> I think it's because it looked like:
> 
> #ifdef CONFIG_FOO
> ....
> #endif /* CONFIG_FOO or CONFIG_BAR */
> 
> and it concluded there was a dependency on BAR.

Or rather like this:

#ifdef CONFIG_FOO
...
#endif /* CONFIG_FO */

Problem is that we humans correct the type before it even reaches our
conciousness.  Machines don't do that yet.

Jörn

-- 
The strong give up and move away, while the weak give up and stay.
-- unknown
