Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267120AbSLDWNK>; Wed, 4 Dec 2002 17:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267122AbSLDWNK>; Wed, 4 Dec 2002 17:13:10 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47377 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267120AbSLDWNJ>; Wed, 4 Dec 2002 17:13:09 -0500
Date: Wed, 4 Dec 2002 22:20:39 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: lkml, bugme.osdl.org?
Message-ID: <20021204222039.A12956@flint.arm.linux.org.uk>
Mail-Followup-To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
	Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
References: <200212030724.gB37O4DL001318@turing-police.cc.vt.edu> <20021203121521.GB30431@suse.de> <20021204115819.GB1137@gallifrey> <20021204124227.GB647@suse.de> <20021204183235.GA701@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021204183235.GA701@gallifrey>; from gilbertd@treblig.org on Wed, Dec 04, 2002 at 06:32:35PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 06:32:35PM +0000, Dr. David Alan Gilbert wrote:
> Indeed - (Alpha is actually one of the few non-x86 architectures
> that actually built fully for me in a recent 2.5.x - and made a passable
> attempt at booting)

One of the ARM machine types which I consider being closest to being
completely buildable in Linus tree was this -><- close to being buildable
between 2.5.49 to 2.5.50.

In 2.5.49, it failed because we had a couple of references in ide.c to
functions previously removed.  In 2.5.50, the IDE DMA stuff changed and
made icside.c unbuildable.  I'm not going to get a chance to look at this
for a while, so don't expect it to change.

Not only that, but the ARM module stuff needs changes in mm/vmalloc.c so
we don't have to have a _third_ ruddy implementation of the same code.
(which currently causes a link error.)  mm/vmalloc.c needs to become more
general - basically "allocate a region of size A alignment B between
address C and address D".  Oh, not to mention the inherently racy code
found within mm/vmalloc.c

I'll now step off my soap box. 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

