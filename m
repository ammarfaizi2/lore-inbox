Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263422AbUCZOfU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 09:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263361AbUCZOfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 09:35:20 -0500
Received: from gprs214-62.eurotel.cz ([160.218.214.62]:47232 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263422AbUCZOfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 09:35:14 -0500
Date: Fri, 26 Mar 2004 15:34:28 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: kernel list <linux-kernel@vger.kernel.org>, seife@suse.de
Subject: Re: swsusp with highmem, testing wanted
Message-ID: <20040326143428.GB291@elf.ucw.cz>
References: <20040324235702.GA497@elf.ucw.cz> <20040325073244.GE3377@suse.de> <20040325115129.GB300@elf.ucw.cz> <20040325121418.GK3377@suse.de> <20040325150129.GI1505@openzaurus.ucw.cz> <20040325152749.GP3377@suse.de> <20040325222205.GC2179@elf.ucw.cz> <20040326140908.GD2929@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040326140908.GD2929@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Which operations are allowed to access highmem? Can I rely on
> > > > block device read/write not accessing highmem?
> > > 
> > > You mean modify highmem pages, or?
> > 
> > I'd like to know this. Suppose I ask block subsystem to read from disk
> > into page @1.8GB. All the highmem contains trash. Will block subsystem
> > be able to work in this situation?
> 
> We've never enforced anything like that, so you cannot rely on it. Block
> layer itself doesn't keep anything in high memory, and I cannot imagine
> any drivers that do either.

Well, if it is possible to enforce that it stays that way, it should
be possible to get something more inteligent for highmem.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
