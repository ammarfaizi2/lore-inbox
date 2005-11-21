Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbVKUN32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbVKUN32 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 08:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVKUN32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 08:29:28 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17541 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750775AbVKUN31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 08:29:27 -0500
Date: Mon, 21 Nov 2005 14:29:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 0/8] Critical Page Pool
Message-ID: <20051121132910.GA1971@elf.ucw.cz>
References: <437E2C69.4000708@us.ibm.com> <20051118195657.GI7991@shell0.pdx.osdl.net> <43815F64.4070502@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43815F64.4070502@us.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > * Matthew Dobson (colpatch@us.ibm.com) wrote:
> > 
> >>/proc/sys/vm/critical_pages: write the number of pages you want to reserve
> >>for the critical pool into this file
> > 
> > 
> > How do you size this pool?
> 
> Trial and error.  If you want networking to survive with no memory other
> than the critical pool for 2 minutes, for example, you pick a random value,
> block all other allocations (I have a test patch to do this), and send a
> boatload of packets at the box.  If it OOMs, you need a bigger pool.
> Lather, rinse, repeat.

...and then you find out that your test was not "bad enough" or that
it needs more memory on different machines. It may be good enough hack
for your usage, but I do not think it belongs in mainline.
								Pavel
-- 
Thanks, Sharp!
