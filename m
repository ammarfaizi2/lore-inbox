Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268883AbUJPVGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268883AbUJPVGG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 17:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268884AbUJPVGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 17:06:06 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:9159 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S268883AbUJPVEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 17:04:04 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: swsusp: 8-order allocation failure on demand (update)
Date: Sat, 16 Oct 2004 23:05:50 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, ncunningham@linuxmail.org
References: <2HO0C-4xh-29@gated-at.bofh.it> <200410162131.19761.rjw@sisk.pl> <20041016204027.GA24434@elf.ucw.cz>
In-Reply-To: <20041016204027.GA24434@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410162305.50794.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 of October 2004 22:40, Pavel Machek wrote:
> Hi!
> 
> > > Unfortunately that's rather ugly. You'd ~32 bytes per 4K page, that's
> > > almost 1% overhead, not nice. Better solution (but more work) is to
> > > switch to link-lists or integrate swsusp2.
> > 
> > Well, I wonder if the page allocation failures are a swsusp problem,
> > really.  
> 
> Yes, they are. Kernel memory allocation is not design to do 8-order
> allocations properly. swsusp really should not use them.

Now that's clear, thanks.  Could you tell me, please, what I need to know to 
understand the swsusp code and what I should start with?

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
