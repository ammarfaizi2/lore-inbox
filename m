Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWIHJTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWIHJTh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 05:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWIHJTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 05:19:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52386 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750748AbWIHJTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 05:19:35 -0400
Subject: Re: [PATCH 14/16] GFS2: The DLM interface module
From: Steven Whitehouse <swhiteho@redhat.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org,
       Russell Cattelan <cattelan@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
In-Reply-To: <Pine.LNX.4.61.0609071832330.24855@yvahk01.tjqt.qr>
References: <1157031710.3384.811.camel@quoit.chygwyn.com>
	 <Pine.LNX.4.61.0609051352110.24010@yvahk01.tjqt.qr>
	 <20060907145823.GF7775@redhat.com>
	 <Pine.LNX.4.61.0609071832330.24855@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 08 Sep 2006 10:26:18 +0100
Message-Id: <1157707578.11901.13.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2006-09-07 at 18:35 +0200, Jan Engelhardt wrote:
> Hi David,
> 
> 
> >> >+int gdlm_get_lock(lm_lockspace_t *lockspace, struct lm_lockname *name,
> >> >+		  lm_lock_t **lockp)
> >>
> >> [lm_lock_t is]
> >> currently typedef'ed to void [...]. (One _could_
> >> get rid of it, but better not while it is called lm_lock_t. Leave as-is
> >> for now.)
> >
> >I'm wondering what you might suggest instead of using the lm_lockspace_t,
> >lm_lock_t, lm_fsdata_t typedefs.  These are opaque objects passed between
> >gfs and the lock modules.  Could you give an example or point to some code
> >that shows what you're thinking?
> 
> What I was thinking about:
> int gdlm_get_lock(void *lockspace, struct lm_lockname *name, void **lockp)
> 
> 
> Jan Engelhardt

I've had a bash at this and the results are here:
http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=9b47c11d1cbedcba685c9bd90c73fd41acdfab0e

Let me know if thats ok,

Steve.


