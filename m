Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292229AbSCDIVJ>; Mon, 4 Mar 2002 03:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292237AbSCDIVA>; Mon, 4 Mar 2002 03:21:00 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:61452 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S292223AbSCDIUn>; Mon, 4 Mar 2002 03:20:43 -0500
From: Helge Hafting <helgehaf@idb.hist.no>
Date: Mon, 4 Mar 2002 09:19:28 +0100
To: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Message-ID: <20020304081928.GA21138@hh.idb.hist.no>
In-Reply-To: <200202281536.g1SFaqF02079@localhost.localdomain> <E16heCm-0000Q5-00@starship.berlin> <757370000.1015212846@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <757370000.1015212846@tiny>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2002 at 10:34:07PM -0500, Chris Mason wrote:
[...]
> 3) Some drives may not be very smart about ordered tags.  We need
> to figure out which is faster, using the ordered tag or using a
> simple cache flush (when writeback is on).  The good news about
> the cache flush is that it doesn't require major surgery in the
> scsi error handlers.

Isn't that a userspace thing?  I.e. use ordered tags in the best
way possible for drives that _are_ smart about ordered tags.
Let the admin change that with a hdparm-like utility
if testing (or specs) confirms that this particular
drive takes a performance hit.  

I thing the days of putting up with any stupid hw is
slowly going away.  Linux is a serious server os these
days, and disk makers will be smart about ordered tags
if some server os do benefit from it.  It won't
really cost them much either.  

Old hw is another story of course - some sort of
fallback might be useful for that. But probably
not for next year's drives. :-)

Helge Hafting
