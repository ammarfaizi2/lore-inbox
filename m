Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263228AbUELI2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbUELI2R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 04:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264920AbUELI2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 04:28:16 -0400
Received: from mail006.syd.optusnet.com.au ([211.29.132.63]:41356 "EHLO
	mail006.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263228AbUELI2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 04:28:15 -0400
From: "Cef (LKML)" <cef-lkml@optusnet.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] adding support for .patches and /proc/patches.gz
Date: Wed, 12 May 2004 18:28:53 +1000
User-Agent: KMail/1.6.2
References: <1084157289.7867.0.camel@latitude> <c7r676$gvo$1@gatekeeper.tmr.com> <1084337968.31228.35.camel@latitude>
In-Reply-To: <1084337968.31228.35.camel@latitude>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405121828.54644.cef-lkml@optusnet.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2004 14:59, Jon Oberheide wrote:
> Any patches applied against the current vanilla kernel.org kernel would
> be listed in .patches.  This would include vendor, third-party, and even
> pre/bk/mm patches.
>
> Keep in mind, .patches would not contain the entire patch, as that would
> be WAY to large, but just a short entry such as the name, date last
> modified, and date applied of the patch file.

A URI would always be nice. That way the originator of the patch can be 
contacted and/or the patch can be fetched easily, all without the original 
kernel source.

In fact, it seems to me that BK (or in fact any patch management system) could 
prove useful here. Not only could it list merged changesets in .patches, it 
could also provide a URI for the author or the repo/patch. And as the kernel 
tree moves and the patches get pushed into releases, the .patches file gets 
cleared of everything that exists in the base tree. Really, something like a 
translated output of the BK changelog for a tree would probably do the job. 
Much like lk-changelog.pl, but more compact information wise. Providing a 
tool at least would get it out in the open and used.

Of course, then you have to define what the base is, and really this should be 
the first thing in .patches - You need to state what the baseline is you're 
comparing against. It'd be good if it wasn't in a separate place. That 
increases it's versatility greatly.

For something like this to happen with BK (ie: as a BitMover provided app), 
you may want to talk to Larry McVoy - it's his baby after all. Of course, you 
could just hack on lk-changelog.pl yourself.

-- 
 Stuart Young (aka Cef)
 cef-lkml@optusnet.com.au is for LKML and related email only
