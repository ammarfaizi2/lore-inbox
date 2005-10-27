Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932580AbVJ0Jge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbVJ0Jge (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 05:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbVJ0Jge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 05:36:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54747 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932580AbVJ0Jgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 05:36:33 -0400
Date: Thu, 27 Oct 2005 02:35:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: rajesh.shah@intel.com, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] export cpu_online_map
Message-Id: <20051027023548.0471db17.akpm@osdl.org>
In-Reply-To: <20051027015504.5a20ed05.pj@sgi.com>
References: <200510260421.j9Q4LGh9014087@shell0.pdx.osdl.net>
	<20051026205038.26a1c333.pj@sgi.com>
	<20051026210803.07efba69.akpm@osdl.org>
	<20051027015504.5a20ed05.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> Andrew wrote:
> > > Since bk no longer works for me, I have no idea how to access any
> > > history prior to about 2.6.12-rc2.  Ugh.
> > 
> > There's still bkbits.net:
> > 
> > http://linux.bkbits.net:8080/linux-2.6/...
> 
> Ok - that helps.  Thanks.
> 
> There is also an hg (mercurial) web based Linux history at:
> 
>   http://www.kernel.org/hg/linux-2.6/
> 
> I still don't see something I can download into a local
> hg or git repository -- if a lurker knows how that is done,
> I'd be glad to know.
> 

I think there are ways of getting the entire kernel history in git too.

I usually just grep my patches directory, actually.  <looks>.  <egad>.
27,000 of them.

> 
> > Seems silly to use cpu_online_map to test for `1'?
> 
> Yeah - agreed.  The include/linux/cpumask.h stuff hardcodes
> the UP (NR_CPUS==1) code to plain old 0's and 1's.  This
> macro should do so as well.
> 
> I just sent a patch.
> 

Sweet, thanks.  Perhaps we can remove cpu_online_map from UP builds soon -
it's really wrong to have it there.
