Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267679AbUBSCQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 21:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267096AbUBSCQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 21:16:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:65410 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267681AbUBSCO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 21:14:56 -0500
Date: Wed, 18 Feb 2004 18:07:29 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: willy@debian.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] How should delete_resource() handle children?
Message-Id: <20040218180729.3b667975.rddunlap@osdl.org>
In-Reply-To: <40341B82.1090403@cyberone.com.au>
References: <20040210193349.GI13351@parcelfarce.linux.theplanet.co.uk>
	<20040218174800.0a3183ec.rddunlap@osdl.org>
	<40341B82.1090403@cyberone.com.au>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004 13:12:18 +1100 Nick Piggin <piggin@cyberone.com.au> wrote:

| 
| 
| Randy.Dunlap wrote:
| 
| >On Tue, 10 Feb 2004 19:33:49 +0000 Matthew Wilcox <willy@debian.org> wrote:
| >
| >| 
| >| If you call release_resource() on a resource that has children, all
| >| of those children are silently removed from the list too.  Does anybody
| >| currently depend on that behaviour?
| >| 
| >
| ...
| 
| >| 
| >| 
| >| Comments?
| >
| >Ideally (or if nothing depends on the current behavior), I think it
| >should just be an error (return -EINVAL), not a BUG_ON().  I.e.,
| >releasing a resource should be an explicit action.
| >
| >
| 
| -EBUSY?

Yes, that makes more sense.

--
~Randy
