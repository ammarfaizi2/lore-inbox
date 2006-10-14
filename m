Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752063AbWJNEkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbWJNEkn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 00:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752065AbWJNEkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 00:40:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:49332 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752063AbWJNEkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 00:40:43 -0400
Date: Fri, 13 Oct 2006 21:40:15 -0700
From: Greg KH <gregkh@suse.de>
To: Paul Jackson <pj@sgi.com>
Cc: Joel Becker <Joel.Becker@oracle.com>, matthltc@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in configfs
Message-ID: <20061014044015.GE16880@suse.de>
References: <6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com> <20061010215808.GK7911@ca-server1.us.oracle.com> <1160527799.1674.91.camel@localhost.localdomain> <20061011012851.GR7911@ca-server1.us.oracle.com> <20061011220619.GB7911@ca-server1.us.oracle.com> <1160619516.18766.209.camel@localhost.localdomain> <20061012070826.GO7911@ca-server1.us.oracle.com> <20061012144420.089f3dce.pj@sgi.com> <20061012225146.GX7911@ca-server1.us.oracle.com> <20061012170125.504153ec.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061012170125.504153ec.pj@sgi.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 05:01:25PM -0700, Paul Jackson wrote:
> Underneath each of these filesystems, sysfs, configfs, cpuset, resource
> groups, ... it would seem ideal if we had a single kernel file system
> infrastructure.  Actually, we're only a half a layer from having that,
> with vfs.  It just takes a fair bit of glue to construct any of these
> file systems out of vfs primitives.

No, it's pretty small to create a ram-based filesystem these days.  Look
at securityfs and debugfs for two simple examples that you should copy
if you want to create your own.  If you can come up with ways of making
those files smaller, then that would be great.  But as it is, it is
_really_ simple to do this right now, especially with two working
examples to copy from :)

thanks,

greg k-h
