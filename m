Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264561AbUE0O0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264561AbUE0O0B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 10:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264562AbUE0O0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 10:26:01 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:12241
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S264561AbUE0OZ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 10:25:58 -0400
Date: Thu, 27 May 2004 10:34:14 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
Message-ID: <20040527103414.A31572@animx.eu.org>
References: <S265353AbUEZI1M/20040526082712Z+1294@vger.kernel.org> <40B4590A.1090006@yahoo.com.au> <40B4667B.5040303@nodivisions.com> <40B46A57.4050209@yahoo.com.au> <20040526161127.A30461@animx.eu.org> <40B583BC.7030706@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <40B583BC.7030706@yahoo.com.au>; from Nick Piggin on Thu, May 27, 2004 at 03:59:24PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I have a question about that.  I keep a debian mirror on one of my machines. 
> > there is over 70000 files.  If I run find on that tree while it's
> > downloading the file list, it doesn't take as long.  I thought it would be
> > nice if there was some way I could keep that in memory.  The box has 256mb
> > ram no swap.  It is configured as diskless.
> > 
> 
> You mean that if you prime the cache by running find on the tree,
> your actual operation doesn't take as long?

Yup.  Running the mirror doesn't matter really.  I start that before I
retire at the end of the day.

> I don't doubt this. Slab cache is shrunk aggressively compared to
> page cache. Traditionally I think this has been due at least in
> part to some failure cases in the balancing there resulting in slab
> growing out of control with some systems.

Where it gets me is the 2nd mirror I have on a usb disk.  Updating it takes
a while.  Although priming the cache on the machine where the usb disk is is
a bit quicker than where the mirror is (rsync over tcp/ip).  Both disks use
ext3, but the machine the usb is on has way more memory, usb2, and overall
quicker than the other.

> These failure cases should be fixed now, and slab vs pagecache is
> probably something that should be looked at again. I really need
> to get my hands on a 2GB+ system before I'd be game to start
> fiddling with too much stuff though.

I've been wanting to upgrade that machine to 768mb, but I don't know if
it'll handle it.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
