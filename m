Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbTDHToy (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 15:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbTDHTox (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 15:44:53 -0400
Received: from [195.39.17.254] ([195.39.17.254]:1028 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id S261672AbTDHTow (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 15:44:52 -0400
Date: Tue, 8 Apr 2003 20:41:09 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Martin Hicks <mort@bork.org>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, wildos@sgi.com
Subject: Re: [patch] printk subsystems
Message-ID: <20030408184109.GA226@elf.ucw.cz>
References: <20030407201337.GE28468@bork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030407201337.GE28468@bork.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> In an effort to get greater control over which printk()'s are logged
> during boot and after, I've put together this patch that introduces the
> concept of printk subsystems.  The problem that some are beginning to
> face with larger machines is that certain subsystems are overly verbose
> (SCSI, USB, cpu related messages on large NUMA or SMP machines)
> and they overflow the buffer.  Making the logbuffer bigger is a stop gap
> solution but I think this is a more elegant solution.

> Basically, each printk is assigned to a subsystem and that subsystem has
> the same set of values that the console_printk array has.  The
> difference is that the console_printk loglevel decides if the message
> goes to the console whereas the subsystem loglevel decides if that
> message goes to the log at all.

Well, I consider this stop gap too... Right solution is to kill
printk()s from too verbose part so that it does not overflow....

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
