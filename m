Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbVHVVoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbVHVVoI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbVHVVoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:44:08 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:32130 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751255AbVHVVoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:44:07 -0400
Date: Mon, 22 Aug 2005 15:42:35 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Chris Wedgwood <cw@f00f.org>
cc: 7eggert@gmx.de, cHitman <samartsev@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH for changing of DVD speed via ioctl() call
In-Reply-To: <20050822023755.GA22851@taniwha.stupidest.org>
Message-ID: <Pine.LNX.4.58.0508221536240.2418@be1.lrz>
References: <4E0p1-3vc-23@gated-at.bofh.it> <E1E6vvy-0000hI-Hj@be1.lrz>
 <20050822023755.GA22851@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Aug 2005, Chris Wedgwood wrote:
> On Sun, Aug 21, 2005 at 09:56:45PM +0200, Bodo Eggert wrote:

> > The parameter value should IMHO be a pointer to a struct {
> >  unsigned long long maxspeed; // (with 0 being the magic max. value?)
> >  int facility; /* 0=general speed, 2=general read, 4=read data,
> >                   6=read audio, 8=read raw ... whatever is supported
> >                   n+1 = s/read/write/ */
> > }
> 
> Passing pointers inside ioctl's is horrible IMO and if we can avoid it
> we should.  It's just asking for problems.

It's used in all ioctls not requiring a read-only int or a void. See man 
ioctl_list (2).
-- 
Top 100 things you don't want the sysadmin to say:
26. What happens to a Hard Disk when you drop it?
