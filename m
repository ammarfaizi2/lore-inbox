Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264335AbTDXATi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 20:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264327AbTDXATh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 20:19:37 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:65411 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S264335AbTDXATe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 20:19:34 -0400
Date: Thu, 24 Apr 2003 10:31:43 +1000
From: CaT <cat@zip.com.au>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>, akpm@digeo.com, pavel@ucw.cz,
       mbligh@aracnet.com, gigerstyle@gmx.ch, geert@linux-m68k.org,
       linux-kernel@vger.kernel.org
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <20030424003143.GC678@zip.com.au>
References: <1051136725.4439.5.camel@laptop-linux> <1584040000.1051140524@flay> <20030423235820.GB32577@atrey.karlin.mff.cuni.cz> <20030423170759.2b4e6294.akpm@digeo.com> <20030424001733.GB678@zip.com.au> <1051143408.4305.15.camel@laptop-linux> <20030423172628.0f71ab64.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423172628.0f71ab64.rddunlap@osdl.org>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 05:26:28PM -0700, Randy.Dunlap wrote:
> | fragmented). The simplest solution is to keep using the current method
> | and create a separate swap partition if you really feel you need to,
> | only turning it on before swap and turning if off afterwards. As Pavel
> | said, code could be added to get swsusp to do it itself.
> 
> That may be simple for you, but for lots of users, adding a partition
> (to a ususally full disk drive) isn't simple.  It means backups,
> shrink a filesystem, shrink a partition, add a partition, and run
> mkswap on it.   Yes, the latter 2 are simple, but the former ones
> are not.
> 
> Oh, and then just start over and install everything from backups. :(

parted should help with this. Dunno if it can move the start of a
partition yet but you can move the end down and put in your suspend
partition in the space you just made.

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
