Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269014AbUJQC51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269014AbUJQC51 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 22:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269015AbUJQC51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 22:57:27 -0400
Received: from hera.kernel.org ([63.209.29.2]:408 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S269014AbUJQC5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 22:57:25 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: 4level page tables for Linux
Date: Sun, 17 Oct 2004 02:57:19 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cksn2f$4dv$1@terminus.zytor.com>
References: <20041014092540.5416.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1097981839 4544 127.0.0.1 (17 Oct 2004 02:57:19 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sun, 17 Oct 2004 02:57:19 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20041014092540.5416.qmail@science.horizon.com>
By author:    linux@horizon.com
In newsgroup: linux.dev.kernel
>
> > Numbers for all of them would be easy to deal with.
> > Like this: pd1, pd2, pd3, pd4...
> > 
> > I'd number going toward the page, because that's
> > the order in which these things get walked.
> 
> On the other hand, these extensions tend to get made to the top,
> and it's confusing if, in a 2-level system, only pd3 and pd4 are used.
> 
> Perhaps a little-endian scheme (pd1 = pte, pt2=pmd, pd4=pgd) would
> be better after all.

I believe so, for the same reason that littleendian actually makes
more sense for numbers in the long run.  It's one of those things
where the "first perception" doesn't match what makes sense in the
long run.

	-hpa
