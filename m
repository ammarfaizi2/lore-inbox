Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264053AbTDWO0Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 10:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264059AbTDWO0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 10:26:16 -0400
Received: from air-2.osdl.org ([65.172.181.6]:7059 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264053AbTDWO0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 10:26:13 -0400
Date: Wed, 23 Apr 2003 07:36:59 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andrew Kirilenko <icedank@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Data storing
Message-Id: <20030423073659.7851c2a1.rddunlap@osdl.org>
In-Reply-To: <200304231528.08720.icedank@gmx.net>
References: <200304231459.37955.icedank@gmx.net>
	<Pine.LNX.4.53.0304230817340.22823@chaos>
	<200304231528.08720.icedank@gmx.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Apr 2003 15:28:08 +0300 Andrew Kirilenko <icedank@gmx.net> wrote:

| > > I need to make some checks (search for particular BIOS version) in the
| > > very start of the kernel. I need to store this data (zero page is pretty
| > > good for this, I think) and access it from arch/i386/boot/setup.S,
| > > arch/i386/boot/compressed/misc.c and in some other places. Can somebody
| > > suggest me good place to put check procedure and how to pass data?
| >
| > I use 0x000001f0 (absolute) for relocating virtual disk code
| > for booting embedded systems. After Linux is up, the code remains
| > untouched. This might be a good location because the BIOS doesn't
| > use it during POST/boot and Linux (currently) leaves it alone.
| > Of course, this doesn't mean that somebody will not destroy this
| > area in the future (probably to spite you and me!!!).
| 
| Yes, I know about this area, as I wrote (Documentation/i386/zero-page.txt). 
| And I even know how to pass parameter from zero-page into kernel space 
| (setup.c). But I need to use this parm, I fetched, in both setup.S and misc.c 
| (see below). And I don't have any ideas about execute order of setup.S, 
| misc.c and setup.c.

Hi,
Some of this early boot info can be found in my (somewhat old)
"Linux 2.4.x Initialization for IA-32", located at
  http://www.xenotime.net/linux/linit/lin240_init_x86.html

--
~Randy
