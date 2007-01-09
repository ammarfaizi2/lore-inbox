Return-Path: <linux-kernel-owner+w=401wt.eu-S1750718AbXAIATZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbXAIATZ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 19:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbXAIATZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 19:19:25 -0500
Received: from smtp.osdl.org ([65.172.181.24]:56831 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750718AbXAIATZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 19:19:25 -0500
Date: Mon, 8 Jan 2007 16:19:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Chinner <dgc@sgi.com>
Cc: Eric Sandeen <sandeen@sandeen.net>,
       linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com
Subject: Re: bd_mount_mutex -> bd_mount_sem (was Re: xfs_file_ioctl /
 xfs_freeze: BUG: warning at kernel/mutex-debug.c:80/debug_mutex_unlock())
Message-Id: <20070108161917.73a4c2c6.akpm@osdl.org>
In-Reply-To: <20070108234728.GC33919298@melbourne.sgi.com>
References: <20070104001420.GA32440@m.safari.iki.fi>
	<20070107213734.GS44411608@melbourne.sgi.com>
	<20070108110323.GA3803@m.safari.iki.fi>
	<45A27416.8030600@sandeen.net>
	<20070108234728.GC33919298@melbourne.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2007 10:47:28 +1100
David Chinner <dgc@sgi.com> wrote:

> On Mon, Jan 08, 2007 at 10:40:54AM -0600, Eric Sandeen wrote:
> > Sami Farin wrote:
> > > On Mon, Jan 08, 2007 at 08:37:34 +1100, David Chinner wrote:
> > > ...
> > >>> fstab was there just fine after -u.
> > >> Oh, that still hasn't been fixed?
> > > 
> > > Looked like it =)
> > 
> > Hm, it was proposed upstream a while ago:
> > 
> > http://lkml.org/lkml/2006/9/27/137
> > 
> > I guess it got lost?
> 
> Seems like it. Andrew, did this ever get queued for merge?

Seems not.  I think people were hoping that various nasties in there
would go away.  We return to userspace with a kernel lock held??
