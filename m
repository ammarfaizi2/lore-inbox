Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbSKXTyn>; Sun, 24 Nov 2002 14:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbSKXTyn>; Sun, 24 Nov 2002 14:54:43 -0500
Received: from [195.39.17.254] ([195.39.17.254]:2820 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261594AbSKXTym>;
	Sun, 24 Nov 2002 14:54:42 -0500
Date: Sat, 23 Nov 2002 23:23:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: Module Refcount & Stuff mini-FAQ
Message-ID: <20021123222334.GB5170@elf.ucw.cz>
References: <20021118230821.8F3822C241@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021118230821.8F3822C241@lists.samba.org>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Q: How does the module remove code work?
> A: It stops the machine by scheduling threads for every other CPU,
>    then they all disable interrupts.  At this stage we know that noone
>    is in try_module_get(), so we can reliably read the counter.  If
>    zero, or the rmmod user specified --wait, we set the live flag to
>    false.  After this, the reference count should not increase, and
>    each module_put() will wake us up, so we can check the counter
>    again.

Where is this implemented? I guess I need this for swsusp...

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
