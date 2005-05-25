Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbVEYL2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbVEYL2L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 07:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbVEYL2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 07:28:11 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8115 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262180AbVEYL2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 07:28:04 -0400
Date: Wed, 25 May 2005 13:27:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.12-rc4, -mm: bad ide-cs problems
Message-ID: <20050525112745.GA1936@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I see some problems in pcmcia subsystem in 2.6.12-rc4:

On compaq nx5000, inserting CF ide card is recognized as anonymous
memory. On compaq evo, it is recognized okay and
mounts/works. Unfortunately when I unplug the card, I get an oops:

Message from syslogd@Elf at Wed May 25 13:25:25 2005 ...
Elf kernel: Unable to handle kernel NULL pointer dereference at
virtual address 00000010

Message from syslogd@Elf at Wed May 25 13:25:25 2005 ...
Elf kernel:  printing eip:

Message from syslogd@Elf at Wed May 25 13:25:25 2005 ...
Elf kernel: *pde = 00000000

Message from syslogd@Elf at Wed May 25 13:25:25 2005 ...
Elf kernel: Oops: 0000 [#1]

. -mm kernel actually works better on nx5000; it behaves similary to
-rc4 on evo; unfortunately it produces similar oops on card unplug.

								Pavel
