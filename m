Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317901AbSGPRYQ>; Tue, 16 Jul 2002 13:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317902AbSGPRYP>; Tue, 16 Jul 2002 13:24:15 -0400
Received: from 216-42-72-142.ppp.netsville.net ([216.42.72.142]:6499 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S317901AbSGPRYP>; Tue, 16 Jul 2002 13:24:15 -0400
Subject: Re: [Announce] device-mapper beta3 (fast snapshots)
From: Chris Mason <mason@suse.com>
To: linux-lvm@sistina.com
Cc: Andrew Theurer <habanero@us.ibm.com>, Kevin Corry <corryk@us.ibm.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020716163157.GA11334@fib011235813.fsnet.co.uk>
References: <3D2F6464.60908@us.ibm.com> <02071513565400.06209@boiler>
	<20020716084234.GA431@fib011235813.fsnet.co.uk>
	<200207161105.49328.habanero@us.ibm.com> 
	<20020716163157.GA11334@fib011235813.fsnet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 16 Jul 2002 13:27:24 -0400
Message-Id: <1026840444.21656.544.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-16 at 12:31, Joe Thornber wrote:

> > Joe, are you absolutely sure these tests had the disk cache disabled?  That's
> > the only hardware thing I can think of that would make a difference.
> 
> Absolutely sure.  Those figures were for a pair of PVs that were
> sharing an IDE cable so I can certainly get things moving faster.

Some IDE drives ignore commands to turn off the write back cache, or
turn it back on when load gets high.

Try iozone -s 50M -i 0 -o with writeback on and off.  If you get the
same answer the benchmarks are suspect....

-chris


