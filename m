Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263643AbUCYWn7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 17:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263684AbUCYWnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 17:43:13 -0500
Received: from gate.crashing.org ([63.228.1.57]:62599 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263680AbUCYWlT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 17:41:19 -0500
Subject: Re: swsusp with highmem, testing wanted
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, seife@suse.de
In-Reply-To: <20040325120250.GC300@elf.ucw.cz>
References: <20040324235702.GA497@elf.ucw.cz>
	 <1080185300.1147.62.camel@gaston>  <20040325120250.GC300@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1080254461.1195.40.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 26 Mar 2004 09:41:01 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'd need to do atomic copy. (Unless someone can guarantee that during
> writing to disk, no highmem page is going to be changed...)
> 
> "copy back" during resume is done in assembly, and I'd rather not
> dealed with highmem there.

Can you make that an option ? The PPC version runs in real mode and
can perfectly copy highmem pages (with small tweaks maybe)

> OTOH, if it possible to guarantee that highmem pages do not change
> during reads/writes to disk, I might be able to get away without this
> copy.

I also think we free too much memory btw (and spend too much time
trying to free memory). Have you looked at some of Nigel stuffs in
swsusp2 ? There may be good ideas to borrow... 

Ben.


