Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264734AbUFTGZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264734AbUFTGZY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 02:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264903AbUFTGZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 02:25:24 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:19704 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264734AbUFTGZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 02:25:23 -0400
Subject: Re: [PATCH] Stop printk printing non-printable chars
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: jbglaw@lug-owl.de, dwmw2@infradead.org, arjanv@redhat.com,
       Linus Torvalds <torvalds@osdl.org>, jbglaw@lug-owl.de,
       matthew-lkml@newtoncomputing.co.uk
Content-Type: text/plain
Organization: 
Message-Id: <1087704177.8185.951.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 20 Jun 2004 00:02:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It is dangerous to let the 0x9b character go out
>> to a serial console. It means the same as ESC [ does
>> when you have a normal 8-bit terminal.
>
> Get real: either you *want* to get those codes
> interpreted (think about full-blown ncurses apps
> being run over serial link), or you *don't* (think
> about simply recording serial console's output).
> You just have to choose the correct application
> for your task.

If there are full-blown ncurses apps being routed
through printk -- that is, the KERNEL log -- then
we have far bigger issues.

The 0x9b character must be blocked, at least when
a serial console is in use. (apps on such a console
may of course use 0x9b as desired -- just not printk)




