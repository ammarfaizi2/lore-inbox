Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbVA3Xai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVA3Xai (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 18:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVA3Xai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 18:30:38 -0500
Received: from gprs214-48.eurotel.cz ([160.218.214.48]:5250 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261837AbVA3XaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 18:30:17 -0500
Date: Mon, 31 Jan 2005 00:30:01 +0100
From: Pavel Machek <pavel@suse.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 ACPI on dell inspiron 8100
Message-ID: <20050130233000.GB2781@elf.ucw.cz>
References: <20050129003448.GA24375@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050129003448.GA24375@animx.eu.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I noticed something strange with ACPI and the battery:
> /proc/acpi/battery/BAT1$ cat info 
> present:                 yes
> design capacity:         57420 mWh
> last full capacity:      57420 mWh
> battery technology:      rechargeable
> design voltage:          14800 mV
> design capacity warning: 3000 mWh
> design capacity low:     1000 mWh
> capacity granularity 1:  200 mWh
> capacity granularity 2:  200 mWh
> model number:            LIP8084DLP
> serial number:           20495
> battery type:            LION
> OEM info:                Sony Corp.
> /proc/acpi/battery/BAT1$ cat state 
> present:                 yes
> capacity state:          ok
> charging state:          charging
> present rate:            unknown
> remaining capacity:      59040 mWh
> present voltage:         16716 mV
> /proc/acpi/battery/BAT1$
> 
> Is my laptop messed up or is ACPI not seeing proper values?  How can I have
> 59040 remaining capacity when it the full capacity is 57420?  Also the
> system didn't display the charging light so I know it's not charging.

That actually looks okay. Perhaps battery now stores more energy than
it did last time. Different temperature or something. I'd not worry
about this one.

I have machine where last full capacity is quite a bit bigger than
design capacity; and that's okay, too.

Heh, but your battery gives 2V more than design voltage. That is
slightly "interesting". Perhaps your voltage sensor is wrong and
that's why remaining capacity is so high... Or perhaps your battery is
slightly better than it should be.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
