Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262890AbTHaWPm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 18:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbTHaWPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 18:15:42 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:29360 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S262890AbTHaWPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 18:15:37 -0400
Date: Mon, 1 Sep 2003 00:15:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Power Management Update
Message-ID: <20030831221523.GA164@elf.ucw.cz>
References: <Pine.LNX.4.33.0308301359570.944-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0308301359570.944-100000@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> My main concerns right now are:

On xe3, you broken both S3 and S4 (relative to -test3). [S3 blanks
screen but does not enter sleep, S4 

On 4030cdt, I could not test S3 due to unrelated ACPI error. I tried
to enter S4 -- its still in progress; you moved io into atomic session
with your "cleanups", so I get about 10000 "scheduling in atomic"
messages. It actually does suspend and resume, but drivers are in very
bad state after that, and machine is about 20x slower than it should
be (you have broken UHCI, this might be side effect; or it might be
one of 1001 other things).

You imported ton of untested crap into -test4. If you want power
managment to get into working state, REVERT THAT CRAP!

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
