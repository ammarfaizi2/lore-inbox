Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264557AbTLCNGK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 08:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264558AbTLCNGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 08:06:10 -0500
Received: from smtp2.wanadoo.fr ([193.252.22.29]:13803 "EHLO
	mwinf0203.wanadoo.fr") by vger.kernel.org with ESMTP
	id S264557AbTLCNGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 08:06:06 -0500
Date: Wed, 3 Dec 2003 14:06:03 +0100
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
       Johannes Stezenbach <js@convergence.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test9 ioctl compile warnings in userspace
Message-ID: <20031203130603.GA7094@iliana>
References: <20031112163750.GB18989@convergence.de> <20031202114350.GA25170@iliana> <20031203125648.GC1947@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031203125648.GC1947@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.4i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 01:56:48PM +0100, Jörn Engel wrote:
> On Tue, 2 December 2003 12:43:50 +0100, Sven Luther wrote:
> > On Wed, Nov 12, 2003 at 05:37:50PM +0100, Johannes Stezenbach wrote:
> > > Hi,
> > > 
> > > the patch below fixes
> > > 
> > >   warning: signed and unsigned type in conditional expression
> > > 
> > > when compiling userspace programs with a glibc built against
> > > 2.6 kernel headers.
> > > 
> > > This is a better version of my previous patch which aims
> > > to fix all affected architectures.
> > 
> > I am curious about this. 
> > 
> > This patch has been proposed since almost a month or more now, and
> > clearly nobody seems to care about this, since it didn't make it in the
> > 2.6.0-test11 tarball (don't know about more recent bk trees though) nor
> > do the debian glibc maintainer judge the issue important enough to act
> > on it (despite it breaking buildage of other packages).
> > 
> > So, is there a reason why not to solve this problem this way, or a
> > particular reason why __invalid_size_argument_for_IOC is still int and
> > not unsigned int ?
> 
> It doesn't clearly fix a bug, afaics.  Also, most kernel hackers don't
> care too much about the signed/unsigned warnings, as they are 99%
> noise.

Well, the main problem is that since the 2.6.0 kernel headers are used
by glibc on debian (and maybe others) it makes building userland
packages about this difficult. I was asking to know if there was
something inherently bad about implementing this in the userland kernel
headers provided by the glibc, as the glibc debian maintainers have not
been responsive about this, but i know since that a fixed package will
be provided once the situation resulting from the intrusion is cleared.

> Resend the patch after 2.6.0 has been released, I don't see any change
> for it to go in before.

But also no particular reason not to use it, right ?

Thanks for your reply.

Friendly,

Sven Luther
