Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264563AbTLCM47 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 07:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264564AbTLCM47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 07:56:59 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:8154 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264563AbTLCM45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 07:56:57 -0500
Date: Wed, 3 Dec 2003 13:56:48 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Johannes Stezenbach <js@convergence.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test9 ioctl compile warnings in userspace
Message-ID: <20031203125648.GC1947@wohnheim.fh-wedel.de>
References: <20031112163750.GB18989@convergence.de> <20031202114350.GA25170@iliana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031202114350.GA25170@iliana>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 December 2003 12:43:50 +0100, Sven Luther wrote:
> On Wed, Nov 12, 2003 at 05:37:50PM +0100, Johannes Stezenbach wrote:
> > Hi,
> > 
> > the patch below fixes
> > 
> >   warning: signed and unsigned type in conditional expression
> > 
> > when compiling userspace programs with a glibc built against
> > 2.6 kernel headers.
> > 
> > This is a better version of my previous patch which aims
> > to fix all affected architectures.
> 
> I am curious about this. 
> 
> This patch has been proposed since almost a month or more now, and
> clearly nobody seems to care about this, since it didn't make it in the
> 2.6.0-test11 tarball (don't know about more recent bk trees though) nor
> do the debian glibc maintainer judge the issue important enough to act
> on it (despite it breaking buildage of other packages).
> 
> So, is there a reason why not to solve this problem this way, or a
> particular reason why __invalid_size_argument_for_IOC is still int and
> not unsigned int ?

It doesn't clearly fix a bug, afaics.  Also, most kernel hackers don't
care too much about the signed/unsigned warnings, as they are 99%
noise.

Resend the patch after 2.6.0 has been released, I don't see any change
for it to go in before.

Jörn

-- 
People will accept your ideas much more readily if you tell them
that Benjamin Franklin said it first.
-- unknown
