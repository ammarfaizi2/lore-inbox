Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270519AbTHGUbb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 16:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270648AbTHGUbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 16:31:31 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:1415 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S270519AbTHGUb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 16:31:28 -0400
Date: Thu, 7 Aug 2003 22:31:14 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [BROKEN PATCH] syscalls leak data via registers?
Message-ID: <20030807203113.GA414@elf.ucw.cz>
References: <1059815183.18860.55.camel@ixodes.goop.org> <20030807103043.GB211@elf.ucw.cz> <1060269116.20515.14.camel@ixodes.goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060269116.20515.14.camel@ixodes.goop.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I believe userspace depends on registers to be preserved over system
> > call, except for eax.
> 
> That's what I was wondering.  Does it?  Is that a documented part of the
> syscall interface?
> 
> >  So what you found is not only security problem,
> > but also crasher bug.
> 
> In these sense that it crashes userspace?

Yes. But I was probably wrong. gcc has to preserve callee saved
registers, and that should be enough.

Information leak looks very much real, through.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
