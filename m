Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbVAIWrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbVAIWrk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 17:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbVAIWrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 17:47:40 -0500
Received: from gprs215-6.eurotel.cz ([160.218.215.6]:31104 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261921AbVAIWr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 17:47:27 -0500
Date: Sun, 9 Jan 2005 23:47:11 +0100
From: Pavel Machek <pavel@ucw.cz>
To: shawvrana@acm.org
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
       plazmcman@softhome.net
Subject: Re: Screwy clock after apm suspend
Message-ID: <20050109224711.GF1353@elf.ucw.cz>
References: <7bb8b8de05010710085ea81da9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bb8b8de05010710085ea81da9@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Just thought I'd add that I too am seeing a big time drift on my
> Thinkpad (T30) without ACPI during an APM suspend w/ 2.6.10.  If I can
> help by testing patches, or providing any additional information,
> please let me know.

Probably code to compensate clock after ACPI suspend breaks apm case
:-(.

arch/i386/kernel/time.c, can you comment out         
jiffies += sleep_length * HZ;

in timer_resume to see if it goes away?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
