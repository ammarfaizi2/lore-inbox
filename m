Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271381AbTHDFgq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 01:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271383AbTHDFgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 01:36:46 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:52450 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S271381AbTHDFgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 01:36:45 -0400
Date: Mon, 4 Aug 2003 01:19:27 -0400
From: Ben Collins <bcollins@debian.org>
To: Steven Micallef <steven.micallef@world.net>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: chroot() breaks syslog() ?
Message-ID: <20030804051927.GA31092@phunnypharm.org>
References: <6416776FCC55D511BC4E0090274EFEF5080024A9@exchange.world.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6416776FCC55D511BC4E0090274EFEF5080024A9@exchange.world.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> connect(3, {sin_family=AF_UNIX, path="/dev/log"}, 16) = -1 ENOENT (No such
> file or directory)
> 
> Is this intentional? If so, is there a work-around? I discovered this when
> debugging 'rwhod', but I imagine there are many more utils that would be
> affected too.

I don't know how it ever did work, if in fact it did for you. /dev/log
is not a kernel device, it's just a normal socket created by syslogd.

Now, if you use devfs, and mount devfs under the chroot, it magically
propogates /dev/log. But that's not the normal thing.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
