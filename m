Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbUCDER6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 23:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbUCDEQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 23:16:34 -0500
Received: from mail.tpgi.com.au ([203.12.160.100]:44721 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S261448AbUCDEKc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 23:10:32 -0500
Subject: Re: Resume only part of device tree?
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1078372625.15323.57.camel@gaston>
References: <1078344202.3203.22.camel@calvin.wpcb.org.au>
	 <1078353622.15320.25.camel@gaston>
	 <1078361326.3203.47.camel@calvin.wpcb.org.au>
	 <1078372625.15323.57.camel@gaston>
Content-Type: text/plain
Message-Id: <1078366036.3218.64.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Thu, 04 Mar 2004 15:07:16 +1300
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay. I'll write it then. Thanks.

Nigel

On Thu, 2004-03-04 at 16:57, Benjamin Herrenschmidt wrote:
> On Thu, 2004-03-04 at 11:48, Nigel Cunningham wrote:
> > Hi.
> > 
> > My implementation saved the image in two parts. 'Pageset 2' contains the
> > LRU pages (active & inactive lists). 'Pageset 1' contains all other data
> > to be saved. At resume time, I read pageset 1 and copy the original
> > kernel data back. Then I want to resume the storage devices and read
> > pageset 2 before resuming all devices and waking everything else up. It
> > would also be good to not resume all devices when writing the state to
> > the swap partition, but I have other means of ensuring the consistency
> > of the image that mean I'm not so worried then.
> 
> I don't see any good way to do that at this point. With a tree
> structure, it would be possible to revive only the parents of
> the storage device you are concerned in, but at this point, we
> don't have this possibility
> 
> Ben.
> 
-- 

