Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291247AbSBMJIm>; Wed, 13 Feb 2002 04:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287045AbSBMJId>; Wed, 13 Feb 2002 04:08:33 -0500
Received: from cmailg3.svr.pol.co.uk ([195.92.195.173]:22887 "EHLO
	cmailg3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S291161AbSBMJIT>; Wed, 13 Feb 2002 04:08:19 -0500
Date: Wed, 13 Feb 2002 09:07:48 +0000
To: Faux Pas III <fauxpas@temp123.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 Oops, maybe LVM ?
Message-ID: <20020213090748.GA2421@fib011235813.fsnet.co.uk>
In-Reply-To: <20020213063548.GA463@temp123.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020213063548.GA463@temp123.org>
User-Agent: Mutt/1.3.27i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh,

On Wed, Feb 13, 2002 at 01:35:48AM -0500, Faux Pas III wrote:
> I'm getting reproducible oopses whenever I pull a file over the network
> off of my LVM filesystem, so not exactly sure where this is coming
> from...  this happens with vanilla 2.4.17 although the kernel that I 
> captured the oops output from has LVM 1.0.2 and posix acls patches on
> it.
> 
> Raw oops text and ksymoops output are at http://www.burdell.org/~fauxpas/

The stack trace doesn't suggest it's an LVM problem, the kjournald
process is oopsing when trying to allocate a buffer_head.  Do you have
any other reason to suspect LVM ?  eg, have you tried it successfully
on a non-LVM device ? have you tried it without the acls patch ?

- Joe
