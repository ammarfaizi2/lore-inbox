Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266553AbUAWHzF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 02:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266554AbUAWHzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 02:55:05 -0500
Received: from gprs157-118.eurotel.cz ([160.218.157.118]:17280 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S266553AbUAWHzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 02:55:01 -0500
Date: Fri, 23 Jan 2004 08:54:51 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Patrick Mochel <mochel@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp vs  pgdir
Message-ID: <20040123075451.GB211@elf.ucw.cz>
References: <1074833921.975.197.camel@gaston> <20040123073426.GA211@elf.ucw.cz> <1074843781.878.1.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074843781.878.1.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > We test that CPU has PSE feature. That means kernel is mapped using
> > 4MB page tables, and I do not have to care about page tables at
> > all.
> 
> Just enlighten me please: How do these 4Mb page tables work ? The pgdir
> entries contain special bits ? Then you at least must make sure the

The pgdir contains special bits, and there are no other levels of page
tables.

Now, I'm apparently rewriting swapper_pg_dir with itself (same
data). That's not too clean, but CPUs do not notice it...

> swapper_pgdir is left intact. This is the case ? (I also suppose you
> mean the entire linear mapping, not just the kernel, is mapped with
> 4M pages)

Yes.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
