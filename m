Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277144AbRJHVbJ>; Mon, 8 Oct 2001 17:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277147AbRJHVbD>; Mon, 8 Oct 2001 17:31:03 -0400
Received: from jaj.com ([209.64.26.3]:57871 "EHLO disaster.jaj.com")
	by vger.kernel.org with ESMTP id <S277144AbRJHVaR>;
	Mon, 8 Oct 2001 17:30:17 -0400
Date: Mon, 8 Oct 2001 17:32:14 -0400
From: Phil Edwards <pedwards@disaster.jaj.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] core file naming option
Message-ID: <20011008173214.A19007@disaster.jaj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After seeing this topic in the Kernel Cousin and reading through the mail
archives, I thought I'd mention a very useful feature that Linux could
steal^H^H^H^H^Hleverage from Solaris:  the coreadm(1) program allows users
to set a pattern for core file names, e.g.,

    /var/core/core.%f.%p

for command foo with pid 1234 dumps core in /var/core/core.foo.1234 (to
use the example from the coreadm man page).  There're about half a dozen
% patterns.

The root user can set patterns and policies systemwide (e.g., no coredumps
for regular users, dump all corefiles everywhere into a directory readable
only by root, etc, for security reasons).  Also, this pattern information
is stored per-process AFAICT, so in my login files I have

    coreadm -p core.%f.%p $$

Meaning that all core files go into the current directory.  It gets set
for the shell itself, and all the processes spawned from that shell.

Both as a user and a sysadmin, I've found this to be very very useful.


Anyhow, just a thought.  Thanks for reading.

Luck++;
Phil

-- 
If ye love wealth greater than liberty, the tranquility of servitude greater
than the animating contest for freedom, go home and leave us in peace.  We seek
not your counsel, nor your arms.  Crouch down and lick the hand that feeds you;
and may posterity forget that ye were our countrymen.            - Samuel Adams
