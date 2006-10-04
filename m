Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161265AbWJDP5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161265AbWJDP5G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 11:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161266AbWJDP5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 11:57:06 -0400
Received: from amsfep19-int.chello.nl ([213.46.243.16]:49775 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S1161265AbWJDP5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 11:57:04 -0400
Subject: Re: 2.6.18: Kernel BUG at mm/rmap.c:522
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andre Noll <maan@systemlinux.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, andrea@suse.de, riel@redhat.com
In-Reply-To: <20061004154227.GD22487@skl-net.de>
References: <20061004104018.GB22487@skl-net.de>
	 <4523BE45.5050205@yahoo.com.au>  <20061004154227.GD22487@skl-net.de>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 17:49:00 +0200
Message-Id: <1159976940.27331.0.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-04 at 17:42 +0200, Andre Noll wrote:
> On 23:59, Nick Piggin wrote:
> 
> > Ah, this old thing. I hope it is repeatable?
> 
> Well, it happened on both of the new machines we got last week. One
> of these is still up BTW and I'm able to ssh into it.
> 
> > What we really want is the bit before this, the "Eeek! page_mapcount went
> > negative" part.
> 
> There's no such message in the log. The preceeding lines are just normal
> startup messages:
> 
> 	Adding 16779852k swap on /dev/sda1.  Priority:42 extents:1 across:16779852k
> 	Adding 16779852k swap on /dev/sdb1.  Priority:42 extents:1 across:16779852k
> 	process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
> 
> > It is also nice if we can work out where the page actually came from. The
> > following attached patch should help out a bit with that, if you could
> > run with it?
> 
> Okay. I'll reboot with your patch and let you know if it crashes again.

enable CONFIG_DEBUG_VM to get that.

