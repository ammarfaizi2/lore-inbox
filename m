Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbTELNDW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 09:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbTELNDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 09:03:22 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:25102 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262119AbTELNDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 09:03:20 -0400
Date: Mon, 12 May 2003 14:16:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ioctl32: kill code duplication (sparc64 tester wanted)
Message-ID: <20030512141600.A29386@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20030512114055.GA3539@atrey.karlin.mff.cuni.cz> <20030512134353.A28931@infradead.org> <20030512130518.GA15227@atrey.karlin.mff.cuni.cz> <20030512140834.A29260@infradead.org> <20030512131326.GB15227@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030512131326.GB15227@atrey.karlin.mff.cuni.cz>; from pavel@ucw.cz on Mon, May 12, 2003 at 03:13:26PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 03:13:26PM +0200, Pavel Machek wrote:
> > What's the reason you can't build fs/compat_ioctl.c normally and pull
> > in the arch magic through a magic asm/ header?  
> 
> Some architectures need special stuff (mtrr's), so I'd have to include
> .c files, too (the other way). [Look at how the table of ioctls is
> generated, its asm magic].

Shouldn't that special stuff move to the dynamic ioctl handler
registration method or the new ->compat_ioctl?

> Are you asking why are there #includes in compat_ioctl.c? Its because
> there is so many of them, and having to update all archs when you
> tuoch fs/compat_ioctl.c would be bad.

I'm asking for the #ifdef INCLUDES in fs/compat_ioctl.c.  Why do you
need it instead of including the headers uncondtionally?

