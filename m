Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271588AbTGQWKA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 18:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271589AbTGQWKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 18:10:00 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:6148 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S271588AbTGQWJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 18:09:58 -0400
Date: Fri, 18 Jul 2003 00:24:51 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, miquels@cistron.nl,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Message-ID: <20030718002451.A2569@pclin040.win.tue.nl>
References: <20030716184609.GA1913@kroah.com> <20030717014410.A2026@pclin040.win.tue.nl> <20030716164917.2a7a46f4.akpm@osdl.org> <20030717122600.A2302@pclin040.win.tue.nl> <bf5uqb$3ei$1@news.cistron.nl> <20030717131955.D2302@pclin040.win.tue.nl> <20030717145507.3ce5042c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030717145507.3ce5042c.akpm@osdl.org>; from akpm@osdl.org on Thu, Jul 17, 2003 at 02:55:07PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 02:55:07PM -0700, Andrew Morton wrote:
> Andries Brouwer <aebr@win.tue.nl> wrote:
> >
> > > The filesystem driver itself must convert from native rdev to linux 32:32.
> > 
> > Look at the mknod utility.
> > The user types major,minor.
> > The system call uses dev_t.
> > This means that user space needs to be able to combine
> > major,minor into a dev_t.
> 
> But mknod64() takes major/minor.  Requiring a fileutils upgrade is OK.

[I think I already answered - please ask again if not.]

Premise: some filesystems or archives store 32 bits.
Conclusion: we must be able to handle that.
This is unrelated to the kernel, unrelated to system calls,
it is related to <sys/sysmacros.h>.

