Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbTH2UIA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbTH2UHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:07:51 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:14015 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S262005AbTH2UGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:06:16 -0400
Date: Thu, 28 Aug 2003 23:19:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [PM] /proc/acpi/sleep needs to stay
Message-ID: <20030828211905.GA380@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

acpi/sleep needs to stay. It is published interface, being used in
2.4.X and 2.6.0-test3. That makes it wrong to change it in
2.6.0-test4. [I've seen two different people trying to use
/proc/acpi/sleep in last week, *in person*.]

Also your new /sys/power/state is bogus. You invented new abstraction,
alas that abstraction is harmfull. User needs to know if he is doing
S4BIOS or swsusp: in first case he needs to set up special partition,
in second case he needs to pass resume= flag.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
