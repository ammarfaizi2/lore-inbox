Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbTKIADw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 19:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbTKIADw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 19:03:52 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:29091 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261606AbTKIADv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 19:03:51 -0500
Date: Sun, 9 Nov 2003 01:03:27 +0100
From: Pavel Machek <pavel@suse.cz>
To: joshk@triplehelix.org,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>, pavel@suse.cz,
       jsimmons@infradead.org
Subject: Re: 2.6.0-test9 status report
Message-ID: <20031109000326.GA1082@elf.ucw.cz>
References: <20031108191304.GB956@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031108191304.GB956@triplehelix.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 1. Software suspend
> 
> This began actually working in -test9. However, if I S4 from within X,
> it will never resume. In fact, it will begin resuming, but then it will
> go 'Waiting for DMAs to calm down' or something, and then reboot, and
> loop rebooting.

Try unloading agp/dri modules before you suspend. Then write
suspend/resume support for them.

> Also, my USB devices will not be re-enabled unless I unplug the hub and
> replug it back in. Is there a way to kick my hotplug manager in the
> shins on resume, or simulate a unplug/replug?

USB should support this, maybe there's some bug in suspend/resume methods?

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
