Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264030AbTGRRuO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 13:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270271AbTGRRuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 13:50:14 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:5015 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S264030AbTGRRuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 13:50:11 -0400
Date: Fri, 18 Jul 2003 20:04:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Peter Osterlund <petero2@telia.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Software suspend testing in 2.6.0-test1
Message-ID: <20030718180449.GB195@elf.ucw.cz>
References: <20030718175045.GA195@elf.ucw.cz> <Pine.LNX.4.44.0307181101110.22018-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307181101110.22018-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I wanted to avoid that: we do want user threads refrigerated at that
> > point so that we know noone is allocating memory as we are trying to
> > do memory shrink. I'd like to avoid having refrigerator run in two
> > phases....
> 
> But we should be the only process running, and we can guarantee that by 
> not sleeping and doing preempt_disable() when we begin. Especially 
> if we start the refrigeration sequence after we shrink
> memory. Right? 

If we refrigerate after we shrink, userspace can allocate everything
just after shrink.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
