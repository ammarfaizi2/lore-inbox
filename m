Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268576AbUIZKBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268576AbUIZKBF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 06:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268590AbUIZKBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 06:01:05 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:12733 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S268576AbUIZKBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 06:01:00 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm3: swsusp horribly slow on AMD64
Date: Sun, 26 Sep 2004 12:02:34 +0200
User-Agent: KMail/1.6.2
Cc: Stefan Seyfried <seife@suse.de>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@suse.cz>
References: <200409251214.28743.rjw@sisk.pl> <4155E40D.2020709@suse.de>
In-Reply-To: <4155E40D.2020709@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409261202.34138.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 of September 2004 23:33, Stefan Seyfried wrote:
> Rafael J. Wysocki wrote:
> > Pavel,
> > 
> > I've just tried to suspend my box and I must admit I've given up after 30 
> > minutes (sic!) of waiting when there were only 12% of pages written to 
disk.  
> > Apparently, swsusp slows down to an unacceptable level after saying "PM: 
> > Writing image to disk".
> 
> is this reproducible?

Yes, it is.  100% of the time, AFAICT, though I've tried it for only a couple 
of times.

> can you get sysrq-t / sysrq-p while it is slow 
> writing to disk?

Well, I'll try, but sysrq didn't work for me at all on 2.6.9-rc2-mm1, so I'm 
not sure if I really can.

> I have seen this, too but i cannot nail it down to some specific
> pattern, it just "sometimes" is slow. Sysrq-p shows me it's almost
> always in "pccardd" (where it shouldn't be during suspend, iiuc).
> Unfortunately Pavel does not see this so we have to convince him that
> this is really a problem ;-)
> So if you can reproduce this, it would be a step in the right direction.

It seems that I can. ;-)

Could it be possible to printk time along with the percentage info (for 
debugging purposes only, of course)?

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
