Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVFAWd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVFAWd1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 18:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVFAWcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 18:32:47 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52914 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261334AbVFAWbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 18:31:21 -0400
Date: Thu, 2 Jun 2005 00:31:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Freezer Patches.
Message-ID: <20050601223101.GD11163@elf.ucw.cz>
References: <1117629212.10328.26.camel@localhost> <20050601130205.GA1940@openzaurus.ucw.cz> <1117663709.13830.34.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117663709.13830.34.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

(Well, it is just after midnight here :-).

> > > Here are the freezer patches. They were prepared against rc3, but I
> > > think they still apply fine against rc5. (Ben, these are the same ones I
> > > sent you the other day).
> > 
> > 304 seems ugly and completely useless for mainline
> 
> That's because you don't understand what it's doing.
> 
> The new refrigerator implementation works like this:
> 
> Userspace processes that begin a sys_*sync gain the process flag
> PF_SYNCTHREAD for the duration of their syscall.

swsusp1 should not need any special casing of sync, right? We can
simply do sys_sync(), then freeze, or something like that. We could
even remove sys_sync() completely; it is not needed for correctness.

								Pavel
