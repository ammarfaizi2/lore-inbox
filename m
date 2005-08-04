Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262632AbVHDTAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262632AbVHDTAh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 15:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbVHDTAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 15:00:35 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:29592 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262613AbVHDTA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 15:00:29 -0400
Date: Thu, 4 Aug 2005 20:59:50 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Nishanth Aravamudan <nacc@us.ibm.com>
cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: Re: [PATCH] push rounding up of relative request to schedule_timeout()
In-Reply-To: <20050804143339.GE4520@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0508042049450.3728@scrub.home>
References: <20050723164310.GD4951@us.ibm.com> <Pine.LNX.4.61.0507231911540.3743@scrub.home>
 <20050723191004.GB4345@us.ibm.com> <Pine.LNX.4.61.0507232151150.3743@scrub.home>
 <20050727222914.GB3291@us.ibm.com> <Pine.LNX.4.61.0507310046590.3728@scrub.home>
 <20050801193522.GA24909@us.ibm.com> <Pine.LNX.4.61.0508031419000.3728@scrub.home>
 <20050804005147.GC4255@us.ibm.com> <Pine.LNX.4.61.0508041123220.3728@scrub.home>
 <20050804143339.GE4520@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 4 Aug 2005, Nishanth Aravamudan wrote:

> The comment for schedule_timeout() claims:
> 
>  * Make the current task sleep until @timeout jiffies have
>  * elapsed.
> 
> Currently, it does not do so. I was simply trying to make the function
> do what it claims it does.

What makes you think the comment is correct? This comment was added at 
2.4.3, while schedule_timeout() has this behaviour since it was added at 
2.1.127.

> My point was that the +1 issues (potential
> infinite timeouts) are a problem with *jiffies* not milliseconds. And
> thus need to be pushed down to the jiffies layer. I think my explanation
> was pretty clear.

Not really, could you go into more details why it's "a problem with 
*jiffies* not milliseconds"?

bye, Roman
