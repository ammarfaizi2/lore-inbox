Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbVKCAiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbVKCAiG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 19:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbVKCAiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 19:38:06 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:25824 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030229AbVKCAiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 19:38:04 -0500
Date: Thu, 3 Nov 2005 11:38:01 +1100
From: Nathan Scott <nathans@sgi.com>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Jan Kasprzak <kas@fi.muni.cz>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: XFS information leak during crash
Message-ID: <20051103113801.E6081538@wobbly.melbourne.sgi.com>
References: <20051102212722.GC6759@fi.muni.cz> <20051103101107.O6239737@wobbly.melbourne.sgi.com> <Pine.LNX.4.62.0511030116160.2023@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.62.0511030116160.2023@artax.karlin.mff.cuni.cz>; from mikulas@artax.karlin.mff.cuni.cz on Thu, Nov 03, 2005 at 01:19:10AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 01:19:10AM +0100, Mikulas Patocka wrote:
> >> either). Does XFS support a something like ext3's "data=ordered" mount
> >> option?
> >
> > No, it doesn't.
> 
> BTW. Why does it sometimes overwrite files with zeros after crash and 
> journal replay then? I thought that this was because it tries to avoid 
> users seeing uninitialized data.

No, thats kinda related but not the same issue, its more to do
with a truncate (or open(O_TRUNC)) followed by buffered writes
to an existing file, which some applications do, and how that
interacts poorly with delayed allocation (nothing is "overwritten
with zeroes", its actually just a "hole").

But I do intend to get _some_ work done today, so you can google
for a more detailed answer there if you're interested.

cheers.

-- 
Nathan
