Return-Path: <linux-kernel-owner+w=401wt.eu-S1750906AbXACQWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbXACQWE (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 11:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbXACQWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 11:22:04 -0500
Received: from colo.lackof.org ([198.49.126.79]:58865 "EHLO colo.lackof.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750906AbXACQWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 11:22:03 -0500
X-Greylist: delayed 1448 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jan 2007 11:22:02 EST
Date: Wed, 3 Jan 2007 08:57:50 -0700
From: dann frazier <dannf@debian.org>
To: mark_salyzyn@adaptec.com, linux-kernel@vger.kernel.org, md@Linux.IT
Cc: 404927@bugs.debian.org, 404927-submitter@bugs.debian.org,
       debian-kernel@lists.debian.org
Subject: udev/aacraid interaction - should aacraid set 'removable'?
Message-ID: <20070103155749.GT13154@colo>
References: <200612290952.kBT9qg6h009021@alpha.it.teithe.gr> <20061229102959.GB10643@bongo.bofh.it> <20070103080325.GN13154@colo> <20070103104951.GC11745@bongo.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070103104951.GC11745@bongo.bofh.it>
User-Agent: mutt-ng/devel-r782 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(lkml readers: this concerns a security issue reported to debian by a
user of udev/aacraid. udev gives the aacraid devices the floppy group
because it reports block devices as 'removable'. See
http://bugs.debian.org/404927 for the entire thread).

On Wed, Jan 03, 2007 at 11:49:51AM +0100, Marco d'Itri wrote:
> On Jan 03, dann frazier <dannf@debian.org> wrote:
> 
> >  Can you elaborate on what you believe the kernel is doing
> > incorrectly? My first guess would be the setting of the removable
> > flag, but aacraid claims to be setting this to prevent partition table
> > caching - do you believe that to be an incorrect usage?
> Yes, this looks like an abuse of the interface to me.

Ok, let's ask lkml

> > It seems like there is precedence for workarounds for older kernels in
> > permissions.rules, so would it be appropriate to add an override of
> > the default floppy rule for aacraid devices for compatability even if
> > this is a kernel bug?
> There are workarounds for bugs which are going to be fixed, but looks
> like this is going to stay forever...
> Are there other drivers in this situation?

I didn't turn up any otherwise when I was grepping yesterday, but my
search terms may have been too naive. I also checked a machine I had
w/ cciss - it did not have the removable flag set.

I found a message from Mark Salyzyn from last year that suggested this
was more pervasive:
  http://www.ussg.iu.edu/hypermail/linux/kernel/0602.2/1231.html
Mark: Can you identify some of these other drivers?


-- 
dann frazier

