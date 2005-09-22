Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbVIVVqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbVIVVqx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 17:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVIVVqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 17:46:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43213 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751202AbVIVVqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 17:46:52 -0400
Date: Thu, 22 Sep 2005 14:46:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: clameter@engr.sgi.com, alokk@calsoftinc.com, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
Message-Id: <20050922144619.05bebbbb.akpm@osdl.org>
In-Reply-To: <43332161.20806@vc.cvut.cz>
References: <4329A6A3.7080506@vc.cvut.cz>
	<20050916023005.4146e499.akpm@osdl.org>
	<432AA00D.4030706@vc.cvut.cz>
	<20050916230809.789d6b0b.akpm@osdl.org>
	<432EE103.5020105@vc.cvut.cz>
	<20050919112912.18daf2eb.akpm@osdl.org>
	<Pine.LNX.4.62.0509191141380.26105@schroedinger.engr.sgi.com>
	<20050919122847.4322df95.akpm@osdl.org>
	<Pine.LNX.4.62.0509191351440.26388@schroedinger.engr.sgi.com>
	<20050919221614.6c01c2d1.akpm@osdl.org>
	<43301578.8040305@vc.cvut.cz>
	<Pine.LNX.4.62.0509201800460.6792@schroedinger.engr.sgi.com>
	<4330B5C2.3080300@vc.cvut.cz>
	<Pine.LNX.4.62.0509210856410.10272@schroedinger.engr.sgi.com>
	<Pine.LNX.4.62.0509221250120.17975@schroedinger.engr.sgi.com>
	<20050922130150.0822b882.akpm@osdl.org>
	<43332161.20806@vc.cvut.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec <vandrove@vc.cvut.cz> wrote:
>
> Andrew Morton wrote:
> > Christoph Lameter <clameter@engr.sgi.com> wrote:
> > 
> >>On Wed, 21 Sep 2005, Christoph Lameter wrote:
> >>
> >> > Hmm. This likely has something to do with debugging code. I was unable to 
> >> > reproduce this on amd64 with your config. I get another failure with 
> >> > 2.6.14-rc2 on ia64 if I enable all the debugging features that you have. 
> >> > The system works fine if no debugging is configured:
> >> > 
> >> > kernel BUG at kernel/workqueue.c:541!
> >> > swapper[1]: bugcheck! 0 [1]
> >>
> >> I fixed the above issue (a structure became larger than the maximum 
> >> allowed by the slab allocator) and the kernel boots fine now on an 8 way 
> >> ia64. Cannot reproduce the problem.
> > 
> > 
> > Petr can.  I think we're still waiting for him to test the below (please):
> 
> Sorry, I've missed that half of email completely.  Yes, it seems to fix problem,
> box has currently 8 min uptime, which is 7:55 more than it survived before.

Great, thanks.   Christoph, was that patch the final official version?

