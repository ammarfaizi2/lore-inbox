Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316895AbSFQKuB>; Mon, 17 Jun 2002 06:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316896AbSFQKuA>; Mon, 17 Jun 2002 06:50:00 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:35333 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316895AbSFQKuA>; Mon, 17 Jun 2002 06:50:00 -0400
Date: Mon, 17 Jun 2002 11:49:57 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/19] writeback tunables
Message-ID: <20020617114957.A4130@flint.arm.linux.org.uk>
References: <3D0D86D7.644F0C13@zip.com.au> <3D0DBAEE.2030409@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D0DBAEE.2030409@evision-ventures.com>; from dalecki@evision-ventures.com on Mon, Jun 17, 2002 at 12:33:18PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2002 at 12:33:18PM +0200, Martin Dalecki wrote:
> 
> > + * The interval between `kupdate'-style writebacks.
> > + */
> > +int dirty_writeback_centisecs = 5 * 100;
> > +
> > +/*
> > + * The largest amount of time for which data is allowed to remain dirty
> > + */
> > +int dirty_expire_centisecs = 30 * 100;
> > +
> 
> Blind guess - didn't the 100 wan't to be HZ?!

The units are centiseconds (as the name suggests). 5 * 100 centiseconds = 5
seconds, so the dirty writeback timeout is 5 seconds.  Check the code a
little further and you'll see HZ gets factored into them on use.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

