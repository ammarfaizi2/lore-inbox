Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272960AbTHKUvw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 16:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272961AbTHKUvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 16:51:52 -0400
Received: from dp.samba.org ([66.70.73.150]:13790 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S272960AbTHKUvu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 16:51:50 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: nagendra_tomar@adaptec.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG in fs/proc/generic.c:proc_file_read 
In-reply-to: Your message of "Thu, 07 Aug 2003 23:59:00 +0530."
             <Pine.LNX.4.44.0308072346020.3811-100000@localhost.localdomain> 
Date: Sun, 10 Aug 2003 15:07:42 +1000
Message-Id: <20030811205149.E1AE92C37D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0308072346020.3811-100000@localhost.localdomain> you write:
> In short:
> The hack used to be able to read proc files larger than 4k, breaks if the 
> caller does lseek() after read()

Hmm, my more(1) does this too.  What a PITA.  less(1) does not.

I've never noticed it before, though.  I certainly didn't notice it
when I implemented the hack.

Of course, converting to seq_file is probably the nicest solution
these days.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
