Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311289AbSCQE1f>; Sat, 16 Mar 2002 23:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311290AbSCQE1O>; Sat, 16 Mar 2002 23:27:14 -0500
Received: from bitmover.com ([192.132.92.2]:56710 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S311289AbSCQE1E>;
	Sat, 16 Mar 2002 23:27:04 -0500
Date: Sat, 16 Mar 2002 20:27:03 -0800
From: Larry McVoy <lm@bitmover.com>
To: Adam Keys <akeys@post.cis.smu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK] Having a hard time updating by pre-patch
Message-ID: <20020316202703.J10086@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Adam Keys <akeys@post.cis.smu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20020317005425.TVMQ1147.rwcrmhc52.attbi.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020317005425.TVMQ1147.rwcrmhc52.attbi.com@there>; from akeys@post.cis.smu.edu on Sat, Mar 16, 2002 at 06:54:00PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 06:54:00PM -0600, Adam Keys wrote:
> First let me describe my goal:  I am trying to get UML working with the 
> recent 2.5.x versions.  Currently, the most recent UML patch for 2.5 is 
> against 2.5.2-pre11.
> 
> What I have done is clone'd http://linux.bkbits.net/linux-2.5 and then cloned 
> that to a working repository.  When I cloned I used -r1.157, which is the 
> revision 2.5.2-pre11 was.  I then apply the UML patch with bk import.  My 
> next step would be to go to rev 1.158 and make sure everything works.  
> Provided everything is OK at that step, I would go to the next rev and repeat.

You can do that and it will take a while because you have to port forward
to each step.  Why not just patch it in at 1.157 and then pull again to
pull it all the way forward?

Anyway, to do what you asked, here's what I'd do:

	bk clone bk://linux.bkbits.net/linux-2.5
	bk clone -lr1.157 linux-2.5 2.5.2-pre11
	bk import -tpatch ....
	bk clone -lr1.158 linux-2.5 next
	bk pull 
	repeat
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
