Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264172AbTICTAS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 15:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264195AbTICS71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:59:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:14210 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264346AbTICS6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:58:05 -0400
Message-Id: <200309031858.h83Iw2p06868@mail.osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Dave Olien <dmo@osdl.org>, linux-kernel@vger.kernel.org, maryedie@osdl.org
Subject: Re: FYI: dbt testing on 2.6.0-test4-mm4 fails 
In-Reply-To: Your message of "Wed, 03 Sep 2003 10:20:42 PDT."
             <20030903102042.52020776.akpm@osdl.org> 
Date: Wed, 03 Sep 2003 11:58:02 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Dave Olien <dmo@osdl.org> wrote:
> >
> > I'm just mailing you this to keep you informed, Daniel McNeil and
> > I are investigating a failure of the dbt database workload test on
> > 2.6.0-test4-mm4.
> 
> hmm, the direct-io code hasn't changed significantly since February(!).
> 
> Which filesystem are you using?

dbt2-1tier uses raw for all the database devices. No filesystems are created
during the run. 

dbt3-pgsl runs on filesystems, and has been running successfully on 
recent kernels. 

cliffw
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
> 
