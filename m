Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751786AbWIGPAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbWIGPAk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 11:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbWIGPAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 11:00:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63188 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751786AbWIGPAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 11:00:39 -0400
Date: Thu, 7 Sep 2006 09:58:23 -0500
From: David Teigland <teigland@redhat.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Steven Whitehouse <swhiteho@redhat.com>, linux-kernel@vger.kernel.org,
       Russell Cattelan <cattelan@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Subject: Re: [PATCH 14/16] GFS2: The DLM interface module
Message-ID: <20060907145823.GF7775@redhat.com>
References: <1157031710.3384.811.camel@quoit.chygwyn.com> <Pine.LNX.4.61.0609051352110.24010@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0609051352110.24010@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2006 at 02:05:14PM +0200, Jan Engelhardt wrote:
> 
> >+int gdlm_get_lock(lm_lockspace_t *lockspace, struct lm_lockname *name,
> >+		  lm_lock_t **lockp)
> >+{
> >+	struct gdlm_lock *lp;
> >+	int error;
> >+
> >+	error = gdlm_create_lp((struct gdlm_ls *) lockspace, name, &lp);
> >+
> >+	*lockp = (lm_lock_t *) lp;
> 
> This cast is alright in itself. Considering however that lm_lock_t is
> currently typedef'ed to void, it looks a little different. (One _could_
> get rid of it, but better not while it is called lm_lock_t. Leave as-is
> for now.)

Hi Jan,

I'm wondering what you might suggest instead of using the lm_lockspace_t,
lm_lock_t, lm_fsdata_t typedefs.  These are opaque objects passed between
gfs and the lock modules.  Could you give an example or point to some code
that shows what you're thinking?

Thanks,
Dave

