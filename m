Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbUK0FRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbUK0FRf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 00:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUK0DzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:55:18 -0500
Received: from zeus.kernel.org ([204.152.189.113]:5572 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262512AbUKZTd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:33:29 -0500
Date: Thu, 25 Nov 2004 23:30:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 9/51: init/* changes.
Message-ID: <20041125223034.GA2711@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101293918.5805.221.camel@desktop.cunninghams> <20041125170718.GA1417@openzaurus.ucw.cz> <1101418614.27250.21.camel@desktop.cunninghams> <20041125214524.GE2488@elf.ucw.cz> <1101419500.27250.41.camel@desktop.cunninghams> <20041125215807.GI2488@elf.ucw.cz> <1101420204.27250.54.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101420204.27250.54.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Parsing major/minor should be as simple as sscanf("%d %d"). And you'll
> > have one less modification to generic code. Yes I think it is worth
> > it.
> 
> In that case, we shouldn't access names at boot time either; the
> interface should be consistent, shouldn't it? I really would prefer to
> keep things as they are; is it worth all this fuss?

/proc file is really different from kernel commandline. Consistent
interface is nice but run-time allocated kernel memory is nicer, and
hooks to common code are not nice. Simply drop that /proc file and we
are done with that fuss.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
