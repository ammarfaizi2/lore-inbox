Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbVLATix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbVLATix (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 14:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbVLATix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 14:38:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13736 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932416AbVLATiw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 14:38:52 -0500
Date: Thu, 1 Dec 2005 11:38:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
cc: Ryan Richter <ryan@tau.solarneutrino.net>, Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Fw: crash on x86_64 - mm related?
In-Reply-To: <Pine.LNX.4.63.0512012040390.5777@kai.makisara.local>
Message-ID: <Pine.LNX.4.64.0512011136000.3099@g5.osdl.org>
References: <20051129092432.0f5742f0.akpm@osdl.org>
 <Pine.LNX.4.63.0512012040390.5777@kai.makisara.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Dec 2005, Kai Makisara wrote:

> On Tue, 29 Nov 2005, Andrew Morton wrote:
> >
> >  Bad page state at free_hot_cold_page (in process 'taper', page ffff81000260b6f8)
> > flags:0x010000000000000c mapping:ffff8100355f1dd8 mapcount:2 count:0
> > Backtrace:

Ryan, can you test 2.6.15-rc4 and report what it does?

The "Bad page state" messages may (should) remain, but the crashes should 
be gone and the machine should hopefully continue functioning fine. And, 
perhaps more importantly, you should hopefully have a _new_ message about 
incomplete pfn mappings that should help pinpoint which driver causes 
this..

		Linus
