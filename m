Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbUKEXcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbUKEXcy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 18:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbUKEXcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 18:32:10 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:35222 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261264AbUKEX10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 18:27:26 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: breakage: flex mmap patch for x86-64
Date: Sat, 6 Nov 2004 00:26:48 +0100
User-Agent: KMail/1.6.2
Cc: Ricky Beam <jfbeam@bluetronic.net>, <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, <arjanv@redhat.com>
References: <Pine.GSO.4.33.0411051751290.9358-100000@sweetums.bluetronic.net>
In-Reply-To: <Pine.GSO.4.33.0411051751290.9358-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200411060026.48571.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 of November 2004 23:54, Ricky Beam wrote:
> On Fri, 5 Nov 2004, Rafael J. Wysocki wrote:
> >> This prevents 32bit apps from running on x86_64.  Backing out the 
Makefile
> >> and processor.h changes has everything working again.  Perhaps something
> >> needs to check for a 32bit environment?  I don't know if it's the change
> >> to TASK_SIZE or the "backwards" mmaps that's the real breakage.  And at 
this
> >> point, I don't have time to test.
> >>
> >> (64bit apps work just fine.)
> >
> >Confirmed, and apparently it is not sifficient to change the TASK_SIZE
> >definition in include/asm-x86_64/processor.h to make the 32-bit userland
> >work.  Hence, it seems that the "backwards" mmaps break things.
> 
> Looks like checking for PER_LINUX32 might fix it...
> 
> >>>      if (current->personality & (ADDR_COMPAT_LAYOUT|PER_LINUX32))

It does not seem to work either.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
