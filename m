Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbTELMzy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 08:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbTELMzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 08:55:53 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:19982 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262099AbTELMzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 08:55:51 -0400
Date: Mon, 12 May 2003 14:08:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ioctl32: kill code duplication (sparc64 tester wanted)
Message-ID: <20030512140834.A29260@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20030512114055.GA3539@atrey.karlin.mff.cuni.cz> <20030512134353.A28931@infradead.org> <20030512130518.GA15227@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030512130518.GA15227@atrey.karlin.mff.cuni.cz>; from pavel@ucw.cz on Mon, May 12, 2003 at 03:05:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 03:05:19PM +0200, Pavel Machek wrote:
> Hi!
> > I don't have a sparc64, but there's certainly no <asm/mtrr.h> for
> > > that arch..
> 
> I thought I killed that one?

The patch you attached added it..

> > Also #including c files is ugly as hell.  What's the #ifdef INCLUDES
> > supposed to help?
> 
> Yes, but do you have better proposal how to kill 4000+ lines of code
> from each 64-bit architecture?

What's the reason you can't build fs/compat_ioctl.c normally and pull
in the arch magic through a magic asm/ header?  You still haven't answered
the second question, btw.. 
