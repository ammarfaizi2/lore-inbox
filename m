Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264481AbTICVOH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 17:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264485AbTICVOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 17:14:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:60382 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264481AbTICVOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 17:14:04 -0400
Date: Wed, 3 Sep 2003 14:14:41 -0700
From: Dave Olien <dmo@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, maryedie@osdl.org
Subject: Re: FYI: dbt testing on 2.6.0-test4-mm4 fails
Message-ID: <20030903211441.GA23932@osdl.org>
References: <20030903170716.GA23487@osdl.org> <20030903102042.52020776.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903102042.52020776.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Right now, we're looking over older test runs and tracking down exactly
which patch set seems to have caused a break.  We THINK we MIGHT have
a difference in behavior between mm3 and mm3-1.

We'll follow this path for a bit and see where it gets us.

But following that, yes we can put some prink's in and see where
that leads.

On Wed, Sep 03, 2003 at 10:20:42AM -0700, Andrew Morton wrote:
> Dave Olien <dmo@osdl.org> wrote:
> >
> > I'm just mailing you this to keep you informed, Daniel McNeil and
> > I are investigating a failure of the dbt database workload test on
> > 2.6.0-test4-mm4.
> 
> hmm, the direct-io code hasn't changed significantly since February(!).
> 
> Which filesystem are you using?
> 
> One possibility is that some lower-level error occured in the filesystem or
> the device driver but the error code was not correctly propagated back. 
> Could you sprinkle error-path printk's in the direct-io code?
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
