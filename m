Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267360AbUIYVfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267360AbUIYVfb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 17:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269416AbUIYVfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 17:35:30 -0400
Received: from cantor.suse.de ([195.135.220.2]:10931 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267360AbUIYVfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 17:35:25 -0400
Message-ID: <4155E40D.2020709@suse.de>
Date: Sat, 25 Sep 2004 23:33:01 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.9-rc2-mm3: swsusp horribly slow on AMD64
References: <200409251214.28743.rjw@sisk.pl>
In-Reply-To: <200409251214.28743.rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> Pavel,
> 
> I've just tried to suspend my box and I must admit I've given up after 30 
> minutes (sic!) of waiting when there were only 12% of pages written to disk.  
> Apparently, swsusp slows down to an unacceptable level after saying "PM: 
> Writing image to disk".

is this reproducible? can you get sysrq-t / sysrq-p while it is slow
writing to disk?
I have seen this, too but i cannot nail it down to some specific
pattern, it just "sometimes" is slow. Sysrq-p shows me it's almost
always in "pccardd" (where it shouldn't be during suspend, iiuc).
Unfortunately Pavel does not see this so we have to convince him that
this is really a problem ;-)
So if you can reproduce this, it would be a step in the right direction.

    Stefan
