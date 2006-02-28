Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWB1WBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWB1WBl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 17:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbWB1WBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 17:01:41 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:41732 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S932334AbWB1WBk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 17:01:40 -0500
Date: Tue, 28 Feb 2006 22:01:28 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>, rmk+lkml@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert serial_core oopses to BUG_ON
Message-ID: <20060228220128.GA4254@unjust.cyrius.com>
References: <20060226100518.GA31256@flint.arm.linux.org.uk> <20060226021414.6a3db942.akpm@osdl.org> <20060227141315.GD2429@ucw.cz> <20060228101713.6fd44027.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060228101713.6fd44027.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@osdl.org> [2006-02-28 10:17]:
> > It will oops in hard-to-guess, place, anyway.
> Will it?   Where?  Unfixably?

http://www.linux-mips.org/archives/linux-mips/2006-02/msg00241.html is
one example we just had on MIPS.  On SGI IP22, using the serial
console, you'd get the following on shutdown:

The system is going down for reboot NOW!
INIT: Sending processes the TERM signal
INIT: Sending proces

and then nothing at all.  I'd never have suspected the serial driver,
had not users reported that the machine shutdowns properly when using
the framebuffer.

For the record, I don't mind whether it's BUG_ON or WARN_ON, but I
just wanted to give this as an example of an "oops in hard-to-guess,
place".
-- 
Martin Michlmayr
tbm@cyrius.com
