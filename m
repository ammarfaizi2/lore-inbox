Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbVKQWd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbVKQWd7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 17:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbVKQWd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 17:33:59 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60047 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964897AbVKQWd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 17:33:58 -0500
Date: Thu, 17 Nov 2005 23:33:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jan Niehusmann <jan@gondor.com>
Cc: bart@samwel.tk, linux-kernel@vger.kernel.org
Subject: Re: Laptop mode causing writes to wrong sectors?
Message-ID: <20051117223340.GD14597@elf.ucw.cz>
References: <20051116181612.GA9231@knautsch.gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051116181612.GA9231@knautsch.gondor.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> let me start by stating that the following is mainly guessed. I may be
> completely wrong. Still I think you may be interested in my
> observations, and perhaps you already got similar reports?
> 
> On my laptop, running 2.6.14, I'm observing some strange file- and
> filesystem corruptions. First, I thought it may have been caused by an
> ext3 bug because the first corruption I did observe happened shortly
> after an ext3 journal replay.
> 
> I did report this to linux-kernel, but without any helpful response:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0511.0/0129.html
> (Subject: ext3 corruption: "JBD: no valid journal superblock found")
> 
> But now, I got another hint pointing to a possible cause of this
> problem: I found a file - /usr/lib/libatlas.so.3.0 - which was corrupted
> by 4k of it being overwritten by a different file, which I recognized. 
> And that file happened to be an uncompressed manual page.
> 
> As usually the manual pages are only stored compressed, this must have
> happened when I actually did look at that manual page, which causes the
> uncompressed version to be written to a file in /tmp/. And the best is:
> I actually remember when I did read that man page, and it was while the
> notebook ran on battery power, which is quite seldom. On battery power,
> I have laptop mode activated and the hard disk spun down after a short
> idle time.
> 
> Why do I think this is related to the corruption? Well, on the one hand,
> I'm compiling kernels quite often, tracking linus' git repository,
> and

Can you try some filesystem test while forcing disk spindowns via
hdparm?

It may be bug in laptop mode, or a bug in ide (or something
related)... trying spindowns without laptopmode would be helpful.

								Pavel
-- 
Thanks, Sharp!
