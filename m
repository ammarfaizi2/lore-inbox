Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131233AbRDFEoH>; Fri, 6 Apr 2001 00:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131236AbRDFEnr>; Fri, 6 Apr 2001 00:43:47 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:10492 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S131233AbRDFEnk>; Fri, 6 Apr 2001 00:43:40 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104060442.f364g4A27761@webber.adilger.int>
Subject: Re: syslog insmod please!
In-Reply-To: <200104060146.f361kYm22348@moisil.dev.hydraweb.com> from Ion Badulescu
 at "Apr 5, 2001 06:46:34 pm"
To: Ion Badulescu <ionut@moisil.cs.columbia.edu>
Date: Thu, 5 Apr 2001 22:42:04 -0600 (MDT)
CC: Andrew Daviel <advax@triumf.ca>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion writes:
> Andrew Daviel <andrew@andrew.triumf.ca> wrote:
> > Is there a good reason why insmod should not call syslog() to log
> > any module that gets installed ? 
> 
> Simple: you'll have quite a bit of a problem if you are trying to insmod
> the module with support for AF_UNIX sockets. :-)

Why do it from user space?  Simply add a printk() to sys_init_module() or
similar.  Granted, this will only help until the lusers install a patched
sysklog before installing a backdoor module, but so would the user-space
solution.  At least the kernel message will stay in kernel memory until
it is flushed out with more messages (which itself might be detectable).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
