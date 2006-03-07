Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWCGB3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWCGB3X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 20:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWCGB3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 20:29:23 -0500
Received: from noname.neutralserver.com ([70.84.186.210]:3788 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S1751212AbWCGB3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 20:29:22 -0500
Date: Tue, 7 Mar 2006 03:30:50 +0200
From: Dan Aloni <da-x@monatomic.org>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Status of AIO
Message-ID: <20060307013049.GA19775@localdomain>
References: <20060306062402.GA25284@localdomain> <20060306211854.GM20768@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306211854.GM20768@kvack.org>
User-Agent: Mutt/1.5.11+cvs20060126
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 04:18:54PM -0500, Benjamin LaHaise wrote:
> On Mon, Mar 06, 2006 at 08:24:03AM +0200, Dan Aloni wrote:
> > Hello,
> > 
> > I'm trying to assert the status of AIO under the current version 
> > of Linux 2.6. However by searching I wasn't able to find any 
> > indication about it's current state. Is there anyone using it
> > under a production environment?
> 
> For O_DIRECT aio things are pretty stable (barring a patch to improve -EIO 
> handling).  The functionality is used by the various databases, so it gets 
> a fair amount of exercise.
> 
> > I'd like to know how complete it is and whether socket AIO is
> > adaquately supported.
> 
> Socket AIO is not supported yet, but it is useful to get user requests to 
> know there is demand for it.

Well, I've written a small test app to see if it works with network
sockets and apparently it did for that small test case (connect() 
with aio_read(), loop with aio_error(), and aio_return()). I thought 
perhaps the glibc implementation was running behind the scene, so I've 
checked to see if it a thread was created in the background and I 
there wasn't any thread. 

-- 
Dan Aloni
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net, dan@xiv.co.il
