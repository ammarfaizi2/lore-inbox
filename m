Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263367AbTJQJwz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 05:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263369AbTJQJwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 05:52:55 -0400
Received: from gprs147-144.eurotel.cz ([160.218.147.144]:62336 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263367AbTJQJww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 05:52:52 -0400
Date: Fri, 17 Oct 2003 11:52:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: unsafe printk
Message-ID: <20031017095240.GB7738@elf.ucw.cz>
References: <1066354577.15921.111.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066354577.15921.111.camel@cube>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Suppose I name an executable this:
> "\n<0>Oops: EIP=0"
> 
> That comes out as a KERN_EMERG log message,
> hitting the console and maybe a pager even.
> 
> There seem to be a number of places in the
> kernel that printk current->comm without
> concern for what it may contain.
> 
> Escape codes and non-ASCII can make for some
> interesting log messages as well. Terminals
> may have some programmable keys or answerback
> messages. So one day root is using grep on
> the log files, and they program the answerback
> string to contain a "\r\nrm -r /\r\n"...

Or at least you can make his terminal pink ;-). Unfortunately same
problem is with userland programs; root does ps and his terminal goes
pink. Sanitizing kernel messages would be good start, but ps&friends
and ls&friends need to be sanitized, too.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
