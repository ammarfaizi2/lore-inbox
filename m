Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWGGP1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWGGP1d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 11:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWGGP1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 11:27:33 -0400
Received: from tim.rpsys.net ([194.106.48.114]:39322 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751082AbWGGP1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 11:27:32 -0400
Subject: Re: [patch] sharpsl_pm refactor
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060707140148.GB4239@ucw.cz>
References: <20060707114818.GA5423@elf.ucw.cz>
	 <1152274600.5548.67.camel@localhost.localdomain>
	 <20060707140148.GB4239@ucw.cz>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 16:24:10 +0100
Message-Id: <1152285850.5548.102.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-07 at 14:01 +0000, Pavel Machek wrote:
> > I'm unconvinced as to why collie needs an ifdef in there and looking at
> > what I think you're leading to, its ugly. Perhaps you could change the 2
> > to a variable set by the machine instead or something, depending upon
> > your intention.
> 
> Well, I hate the if/else maze -- IMO returns are more readable. Anyway
> collie needs both count and time checks disabled, AFAICT.

To me it looks much worse after you changed it as I can understand it at
the moment and afterwards with the ifdefs in, I can't.

Ignoring that issue, why does collie need them disabled? Do they break
collie somehow or is this just because the sharp driver didn't do it?

I'd prefer to keep the charging techniques the same across as many of
the devices as we can and I can't see how this technique causes a
problem. The charging hardware and the battery is very similar across
the models (although you wouldn't believe it looking at the charging
driver).

Richard


