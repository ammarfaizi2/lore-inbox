Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbUBFQrg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 11:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265532AbUBFQrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 11:47:36 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:58543 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S265531AbUBFQre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 11:47:34 -0500
From: Michael Frank <mhf@linuxmail.org>
To: Rik van Riel <riel@redhat.com>, Jens Axboe <axboe@suse.de>
Subject: Re: 2.4.25-rc1: BUG: wrong zone alignment, it will crash
Date: Sat, 7 Feb 2004 00:46:31 +0800
User-Agent: KMail/1.5.4
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0402061034210.5933-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0402061034210.5933-100000@chimarrao.boston.redhat.com>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402070046.31218.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 February 2004 23:36, Rik van Riel wrote:
> On Fri, 6 Feb 2004, Michael Frank wrote:
> 
> > > > 300MB HIGHMEM available.
> > > > 195MB LOWMEM available.
> > > > On node 0 totalpages: 126960
> > > > zone(0): 4096 pages.
> > > > zone(1): 46064 pages.
> > > > zone(2): 76800 pages.
> > > > BUG: wrong zone alignment, it will crash
> 
> > It is supposed to work, just a bug in the zone alignment code.
> 
> The error isn't in the kernel, it's between the chair and the keyboard.
> You have created a lowmem zone of a size that doesn't correctly
> align with the largest blocks used by the buddy allocator.
> 
> > I have have to use HIGHMEM emulation for testing.
> 
> Then you'll need to choose a different size for the highmem=
> parameter, one that doesn't cause an unaligned boundary.

Which is not user friendly and does not match the documentation.

> 
> Alternatively, you could submit a patch so the highmem= boot
> option parsing code does the aligning for you.

OK, will do. I'll produce and test a patch.

> 
> However, that would simply be an improvement to the kernel and
> nothing like a bug you can demand to get fixed now.

OK, Please note that I only passed on the message produced by the kernel 
  BUG: wrong zone alignment, it will crash 

Perhaps the kernel should have reported it as "Invalid value for highmem" 
instead of "BUG" ;)

Thank you

Michael


