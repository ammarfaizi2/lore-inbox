Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262253AbVF2RU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbVF2RU1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 13:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262618AbVF2RMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 13:12:48 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:48768 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262633AbVF2RKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 13:10:25 -0400
Date: Wed, 29 Jun 2005 10:10:21 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Genadz Batsyan <gbatyan@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Newbie: added function not visible
Message-Id: <20050629101021.576f74f5.rdunlap@xenotime.net>
In-Reply-To: <200506291859.04965.gbatyan@gmx.net>
References: <200506291859.04965.gbatyan@gmx.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2005 18:59:04 +0200 Genadz Batsyan wrote:

| I'm desperate, please help, if I'm missing something obvious.
| 
| I am trying to add a function to the file drivers/char/keyboard.c
| and then be able to call this function from my kernel module
| 
| adding the function to keyboard.c, recompiling and booting with kernel
| results  /proc/kallsyms telling me that my function exists with the tag 'T',
| which I think is ok

also add:
EXPORT_SYMBOL(new_symbol); /* whatever the new entry point is */

That makes it visible to modules.

| In my module I simply declare the function's prototype and use it.
| 
| When trying to compile the module, modpost tells that the function's symbol
| is not found. (insmodding results in error too)
| 
| I don't get it, WHY tha heck can it find all the other stuff and 
| what makes this new function different? I have read that 2.6 kernel exports
| any non-static symbols.


---
~Randy
