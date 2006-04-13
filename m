Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWDMNuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWDMNuE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 09:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWDMNuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 09:50:03 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:55956 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S964932AbWDMNuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 09:50:01 -0400
Date: Thu, 13 Apr 2006 15:50:00 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Jes Sorensen <jes@sgi.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com, stern@rowland.harvard.edu, sekharan@us.ibm.com,
       akpm@osdl.org, David Chinner <dgc@sgi.com>
Subject: Re: notifier chain problem? (was Re: 2.6.17-rc1 did break XFS)
Message-ID: <20060413135000.GB6663@MAIL.13thfloor.at>
Mail-Followup-To: Jes Sorensen <jes@sgi.com>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>,
	linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
	stern@rowland.harvard.edu, sekharan@us.ibm.com, akpm@osdl.org,
	David Chinner <dgc@sgi.com>
References: <20060413052145.GA31435@MAIL.13thfloor.at> <20060413072325.GF2732@melbourne.sgi.com> <yq0k69tuauh.fsf@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq0k69tuauh.fsf@jaguar.mkp.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 04:40:54AM -0400, Jes Sorensen wrote:
> >>>>> "David" == David Chinner <dgc@sgi.com> writes:
> 
> David> On Thu, Apr 13, 2006 at 07:21:45AM +0200, Herbert Poetzl wrote:
> David> It looks like we landed on top of a a notifier call chain
> David> implementation change in -rc1. However, this should not matter
> David> to XFS because the interface to register_cpu_notifier() did not
> David> change and XFS is completely abstracted away from the notifier
> David> chain implementation. We do:
> 
> Dave,
> 
> Looks strange, the faulting address is in the same region as the
> eip. I am not that strong on x86 layouts, so I am not sure whether
> 0x78xxxxxx is the kernel's mapping or it's module space. Almost looks
> like something else had registered a notifier and then gone away
> without unregistering it.

sorry, the essential data I didn't provide here is
probably that I configured the 2G/2G split, which for
unknown reasons actually is a 2.125/1.875 split and
starts at 0x78000000 (instead of 0x80000000)

> Herbert, any chance you can make the complete boot log up to the point
> where it crashes, as well as a System.map and your .config available?
> (probably not posted to all the lists :)

sure, bootup is fine, as it boots on ext2/3 but once
it is up, and I mount the newly created xfs filesystem
the (virtual) machine (QEMU) panics ...

will provide all the data shortly via separated mail

best,
Herbert

> Cheers,
> Jes
> 
