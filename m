Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262150AbUK0ERt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbUK0ERt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 23:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbUK0D6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:58:36 -0500
Received: from zeus.kernel.org ([204.152.189.113]:53187 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261215AbUKZTbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:31:06 -0500
Date: Thu, 25 Nov 2004 22:45:24 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 9/51: init/* changes.
Message-ID: <20041125214524.GE2488@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101293918.5805.221.camel@desktop.cunninghams> <20041125170718.GA1417@openzaurus.ucw.cz> <1101418614.27250.21.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101418614.27250.21.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > And if you really want to make it changeable, pass major:minor from userland; once
> > userland is running getting them is easy.
> 
> Yes, but that's also far uglier, and who thinks in terms of major and
> minor numbers anyway? I think of my harddrive as /dev/sda, not 08:xx.
> The parsing accepts majors and minors, of course, but shouldn't we make
> these things easier to do, not harder? (Would we insist on using majors
> and minors for root=?).

Kernel interface is not supposed to be "easy". root= has exception,
that's init code, and you can't easily ls -al /dev at that point. If
you want easy interface, create userland program that looks up
minor/major in /dev/ and uses them.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
