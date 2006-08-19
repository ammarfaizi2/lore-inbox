Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbWHSKxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWHSKxt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 06:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWHSKxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 06:53:49 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:53384 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750978AbWHSKxs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 06:53:48 -0400
Date: Sat, 19 Aug 2006 12:50:31 +0200
To: Andi Kleen <ak@suse.de>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm1 - time moving at 3x speed, bisect finished
Message-ID: <20060819105031.GA3190@aitel.hist.no>
References: <20060813012454.f1d52189.akpm@osdl.org> <200608181134.02427.ak@suse.de> <44E588AB.3050900@aitel.hist.no> <200608181255.46999.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608181255.46999.ak@suse.de>
User-Agent: Mutt/1.5.12-2006-07-14
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 12:55:46PM +0200, Andi Kleen wrote:
> 
> > I have narrowed it down.  2.6.18-rc4 does not have the 3x time
> > problem,  while mm1 have it.  mm1 without the hotfix jiffies
> > patch is just as bad.
> 
> Can you narrow it down to a specific patch in -mm? 
>
The guilty patch is:
ntp-add-ntp_update_frequency.patch

Up to and including the previous patch,
wich is ntp-move-all-the-ntp-related-code-to-ntpc-fix.patch,
everything is fine.  But apply this one, and
time moves at 3x speed.  This makes games interesting,
and the keyboard autorepeat awesome. :-)

The patch found seems reasonable, it is 
definitely time-related.

Thanks to all who sent a tutorial on quilt bisection!

Helge Hafting

