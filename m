Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263865AbUE1ULw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263865AbUE1ULw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 16:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263864AbUE1ULw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 16:11:52 -0400
Received: from calvin.stupendous.org ([213.84.70.4]:12548 "HELO
	quadpro.stupendous.org") by vger.kernel.org with SMTP
	id S263868AbUE1ULl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 16:11:41 -0400
Date: Fri, 28 May 2004 22:11:39 +0200
From: Jurjen Oskam <jurjen@stupendous.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] 2.6.6 tty_io.c hangup locking
Message-ID: <20040528201139.GA12281@quadpro.stupendous.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040527174509.GA1654@quadpro.stupendous.org> <1085769769.2106.23.camel@deimos.microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085769769.2106.23.camel@deimos.microgate.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 01:42:50PM -0500, Paul Fulghum wrote:

> Up to now, this did not cause any actual problems.
> In 2.6.X this causes a warning if any of the called functions
> (flush_buffer/write_wakeup) call spin_xxx_bh() functions.

It was not only a warning here, but the pptp client also didn't work again
until after rebooting. Every time the connection was retried (every 10
seconds or so) the message appeared. Perhaps this is a problem in the pptp
client, but after rebooting it worked.

As for the patch: applied to vanilla 2.6.5 (applied cleanly, offset -5
lines) and compiling now.

One problem though: I'm running 2.6 for about two weeks now (with a 24x7
pptp connection), and I encountered this problem just once. I've seen a
report that someone got this error when his connection was severed, so
I'll try to pull the phone cable a few times and see how it recovers, both
with and without your patch. I'll report back when I know more.

Thanks,
-- 
Jurjen Oskam

"Avoid putting a paging file on a fault-tolerant drive, such as a mirrored
volume or a RAID-5 volume. Paging files do not need fault-tolerance."-MS Q308417
