Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbTDEDJk (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 22:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbTDEDJj (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 22:09:39 -0500
Received: from [12.47.58.55] ([12.47.58.55]:62557 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261719AbTDEDJj (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 22:09:39 -0500
Date: Fri, 4 Apr 2003 19:22:01 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: andrea@suse.de, mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-Id: <20030404192201.75794957.akpm@digeo.com>
In-Reply-To: <12880000.1049508832@flay>
References: <Pine.LNX.4.44.0304041453160.1708-100000@localhost.localdomain>
	<20030404105417.3a8c22cc.akpm@digeo.com>
	<20030404214547.GB16293@dualathlon.random>
	<20030404150744.7e213331.akpm@digeo.com>
	<20030405000352.GF16293@dualathlon.random>
	<20030404163154.77f19d9e.akpm@digeo.com>
	<12880000.1049508832@flay>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Apr 2003 03:21:02.0577 (UTC) FILETIME=[62DAEE10:01C2FB22]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> >   objrmap does not seem to help.  Page clustering might, but is unlikely to
> >   be enabled on the machines which actually care about the overhead.
> 
> eh? Not sure what you mean by that. It helped massively ...
> diffprofile from kernbench showed:
> 
>      -4666   -74.9% page_add_rmap
>     -10666   -92.0% page_remove_rmap
> 
> I'd say that about an 85% reduction in cost is pretty damned fine ;-)
> And that was about a 20% overall reduction in the system time for the
> test too ... that was all for partial objrmap (file backed, not anon).
> 

In the test I use (my patch management scripts, which is basically bash
forking its brains out) objrmap reclaims only 30-50% of the rmap CPU
overhead.

Maybe you had a very high sharing level.
