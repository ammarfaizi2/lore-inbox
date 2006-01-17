Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbWAQVzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWAQVzA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 16:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWAQVzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 16:55:00 -0500
Received: from customer-domains.icp-qv1-irony7.iinet.net.au ([203.59.1.128]:22299
	"EHLO customer-domains.icp-qv1-irony7.iinet.net.au")
	by vger.kernel.org with ESMTP id S932438AbWAQVy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 16:54:59 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
Message-ID: <43CD67AE.9030501@eyal.emu.id.au>
Date: Wed, 18 Jan 2006 08:54:54 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.16-rc1
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Ok, it's two weeks since 2.6.15, and the merge window is closed.

I am looking at a problem where the build seems to remove /dev/null,
which is then created as a regular file (naturally). This did not
happen before.

# ls -l /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 08:42 /dev/null
# make distclean
  CLEAN   scripts/basic
  CLEAN   scripts/kconfig
  CLEAN   include/config
  CLEAN   .config .config.old include/asm include/linux/autoconf.h include/linux/version.h .kernelrelease
# ls -l /dev/null
-rwxr-xr-x  1 root root 47 Jan 18 08:42 /dev/null

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
