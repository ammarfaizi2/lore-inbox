Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266513AbUG0Tqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266513AbUG0Tqp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 15:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266519AbUG0Tqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 15:46:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39326 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266513AbUG0Tqg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 15:46:36 -0400
Date: Tue, 27 Jul 2004 15:58:59 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Robin Holt <holt@sgi.com>
Cc: Keith Owens <kaos@ocs.com.au>, Marcin Owsiany <marcin@owsiany.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: "swap_free: Unused swap offset entry 00000100" but no crash?
Message-ID: <20040727185859.GB19107@logos.cnet>
References: <20040727002154.GA21628@melina.ds14.agh.edu.pl> <3808.1090931402@ocs3.ocs.com.au> <20040727125304.GA1411@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040727125304.GA1411@lnx-holt.americas.sgi.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2004 at 07:53:04AM -0500, Robin Holt wrote:
> On Tue, Jul 27, 2004 at 10:30:02PM +1000, Keith Owens wrote:
> > On Tue, 27 Jul 2004 02:21:54 +0200, 
> > Marcin Owsiany <marcin@owsiany.pl> wrote:
> > >    kernel: swap_free: Unused swap offset entry 00000100
> > >Also, I would be grateful if someone could explain what is that number in the
> > >message supposed to be? An address?
> > 
> > It is a swap partition number, but I doubt that you have 256 swap
> > partitions in your system.  Single bit set in a word that is meant to
> > be 0, most likely to be caused by a hardware single bit error.  Run
> > memtest, burn86 or other memory verification checks.
> > 
> 
> I remember a race condition I thought was possible, but couldn't exactly
> pin down the exact sequence.  Give me a chance to dig through some of
> my notes and see what I come across.

Would love to hear more details about this.

> I think I could understand this if there two messages with each invocation,
> but not with one.
> 
> Marcin, you have a process with a Page Table Entry which indicates it is
> pointing to a page which has been swapped out to block 0 of swap device
> 256.  This is probably caused by a problem in the kernel.  You can certainly
> run memtest et al.  If you don't find anything, I would assume the problem
> is in the kernel.

Marcin, please run the memtest86 and report back.

> Most of the code in the area you would be affected by has changed
> drastically in the 2.6 kernel.

