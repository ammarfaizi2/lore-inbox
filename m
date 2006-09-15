Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWIOGIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWIOGIq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 02:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWIOGIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 02:08:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29577 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750796AbWIOGIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 02:08:45 -0400
Date: Thu, 14 Sep 2006 23:08:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jes Sorensen <jes@sgi.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [RFC - Patch] Condense output of show_free_areas()
Message-Id: <20060914230837.e8c53801.akpm@osdl.org>
In-Reply-To: <yq0mz92efsd.fsf@jaguar.mkp.net>
References: <yq0mz92efsd.fsf@jaguar.mkp.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Sep 2006 09:30:58 -0400
Jes Sorensen <jes@sgi.com> wrote:

> On larger systems, the amount of output dumped on the console when you
> do SysRq-M is beyond insane. This patch is trying to reduce it
> somewhat as even with the smaller NUMA systems that have hit the
> desktop this seems to be a fair thing to do.
> 
> The philosophy I have taken is as follows:
>  1) If a zone is empty, don't tell, we don't need yet another line
>     telling us so. The information is available since one can look up
>     the fact how many zones were initialized in the first place.
>  2) Put as much information on a line is possible, if it can be done
>     in one line, rahter than two, then do it in one. I tried to format
>     the temperature stuff for easy reading.
> 
> Comments?
> 
> Cheers,
> Jes
> 
> Change show_free_areas() to not print lines for empty zones. If no zone
> output is printed, the zone is empty. This reduces the number of lines
> dumped to the console in sysrq on a large system by several thousand
> lines.
> 
> Change the zone temperature printouts to use one line per CPU instead
> of two lines (one hot, one cold). On a 1024 CPU, 1024 node system, this
> reduces the console output by over a million lines of output.
> 
> While this is a bigger problem on large NUMA systems, it is also
> applicable to smaller desktop sized and mid range NUMA systems.

Could you please send us an example of the new output for review,
and for me to include in the changelog?  Thanks.
