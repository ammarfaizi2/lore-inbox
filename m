Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbTESKRm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 06:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbTESKRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 06:17:41 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:30730 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262331AbTESKRk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 06:17:40 -0400
Message-ID: <3EC8B1FC.9080106@aitel.hist.no>
Date: Mon, 19 May 2003 12:29:16 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: ptb@it.uc3m.es
CC: linux-kernel@vger.kernel.org
Subject: Re: recursive spinlocks. Shoot.
References: <200305181724.h4IHOHU24241@oboe.it.uc3m.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter T. Breuer wrote:

> Hey, that's not bad for a small change! 50% of potential programming
> errors sent to the dustbin without ever being encountered.

Then you replace errors with inefficiency - nobody discovers that
you needlessly take a lock twice.  They notice OOPSes though, the
lock gurus can then debug it.

Trading performance for simplicity is ok in some cases, but I have a strong
felling this isn't one of them.  Consider how people optimize locking
by shaving off a single cycle when they can, and try to avoid
locking as much as possible for that big smp scalability.

This is something better done right - people should just take the
trouble.

Helge Hafting

