Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265213AbTLaR0n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 12:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265214AbTLaR0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 12:26:43 -0500
Received: from www.jubileegroup.co.uk ([212.22.195.7]:24528 "EHLO
	www2.jubileegroup.co.uk") by vger.kernel.org with ESMTP
	id S265213AbTLaR0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 12:26:42 -0500
Date: Wed, 31 Dec 2003 17:26:26 +0000 (GMT)
From: Ged Haywood <ged@www2.jubileegroup.co.uk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: rddunlap@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: All filesystems hang under long periods of heavy load (read and
 write) on a filesystem
In-Reply-To: <Pine.LNX.4.58L.0312281816140.15034@logos.cnet>
Message-ID: <Pine.LNX.4.21.0312292153150.405-100000@www2.jubileegroup.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

On Mon, 29 Dec 2003, Marcelo Tosatti wrote:

> > there is certainly something nasty in the released 2.4.23 IDE code...
> 
> The attached patch from Daniel Lux should fix it. Its has just been
> applied to the 2.4 BK tree.
> 
> Please try it.

Thanks very much for the patch, I can see how that piece of code could
well be causing the problem.

Between my message and your reply, someone else came up with another
clue for me and I found that enabling DMA for the drive appears if not
to fix the problem at least to avoid it fairly well.  I think using
DMA for most of the transfers makes it less likely that the lockup
will be triggered.  At least this gets me out of the immediate bind.

It's a busy machine and it's a little painful to keep rebooting it.
I'm going to put an identical one together for testing.  When I've
done that I'll test the patch to destruction.

It will be a couple of weeks before I can get to the bench to do it,
but then it should only take a few hours to be sure it's a good fix.
I'll certainly get back to you with the results.

Thanks again for the pointer.

73,
Ged.


