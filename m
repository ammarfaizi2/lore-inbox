Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265196AbUFMP5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbUFMP5r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 11:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265197AbUFMP5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 11:57:47 -0400
Received: from gprs214-6.eurotel.cz ([160.218.214.6]:22400 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265196AbUFMP5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 11:57:46 -0400
Date: Sun, 13 Jun 2004 17:57:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jeff Sipek <jeffpc@optonline.net>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@osdl.org>, herbert@gondor.apana.org.au,
       mochel@digitalimplant.org, linux-kernel@vger.kernel.org
Subject: Re: Fix memory leak in swsusp
Message-ID: <20040613155724.GA2683@elf.ucw.cz>
References: <20040609130451.GA23107@elf.ucw.cz> <20040611210059.2522e02d.akpm@osdl.org> <40CB7EBD.2020109@linuxmail.org> <200406121932.49477.jeffpc@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406121932.49477.jeffpc@optonline.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > At some stage, you copy the page that contains the preempt count for the
> > process that is doing the suspending. If you use memcpy on a 3Dnow machine,
> > the preempt count is incremented prior to doing the copy of the page. Then,
> > at resume time, it is one too high.
> 
> Well, if we know that it is one too high, why not decrement right after the 
> resume?

You are suggesting very dirty hack. See archives why it is basically
undoable.

									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
