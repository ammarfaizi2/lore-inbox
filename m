Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161251AbWGNENO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161251AbWGNENO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 00:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161252AbWGNENO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 00:13:14 -0400
Received: from 1wt.eu ([62.212.114.60]:19210 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1161251AbWGNENO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 00:13:14 -0400
Date: Fri, 14 Jul 2006 06:12:54 +0200
From: Willy Tarreau <w@1wt.eu>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: memory corruptor in .18rc1-git
Message-ID: <20060714041254.GG2037@1wt.eu>
References: <20060713221330.GB3371@redhat.com> <20060713152425.86412ea3.akpm@osdl.org> <20060713223029.GD3371@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713223029.GD3371@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 06:30:29PM -0400, Dave Jones wrote:
> On Thu, Jul 13, 2006 at 03:24:25PM -0700, Andrew Morton wrote:
> 
>  > > I've up'd the speed of the serial console, in the hope that more chars
>  > > make it over the wire before reboot should this happen again.
>  > 
>  > Are you using SMP?  We have a known slab locking bug.
> 
> Yes, dual EM64T's with HT.
> 
>  > There have been a couple of slab.c patches committed today, but neither of
>  > them appear to actually fix the bug.
>  > 
>  > The below should fix it, and testing this (disable lockdep) would be
>  > useful.
> 
> I can give it a shot, but as it takes a while for this to manifest, I may
> not be able to say for certain whether it fixes it or not.

Then you might consider slightly changing the debug messages, because they
are identical in list_add and list_del. Having a way to differenciate
between the two functions might give one more indication.

> 		Dave

Willy

