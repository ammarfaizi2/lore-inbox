Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751507AbWHNQ16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbWHNQ16 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 12:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbWHNQ16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 12:27:58 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:23679 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1751507AbWHNQ14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 12:27:56 -0400
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Thomas Koeller <thomas@koeller.dyndns.org>,
       Dave Jones <davej@redhat.com>, wim@iguana.be,
       linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
       linux-mips@linux-mips.org
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
X-Message-Flag: Warning: May contain useful information
References: <200608102319.13679.thomas@koeller.dyndns.org>
	<20060811205639.GK26930@redhat.com>
	<200608120149.23380.thomas@koeller.dyndns.org>
	<20060814141445.GA10763@nineveh.rivenstone.net>
	<20060814153033.GA25215@mars.ravnborg.org>
	<20060814092124.84f7ff3e.rdunlap@xenotime.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 14 Aug 2006 09:27:55 -0700
In-Reply-To: <20060814092124.84f7ff3e.rdunlap@xenotime.net> (Randy Dunlap's message of "Mon, 14 Aug 2006 09:21:24 -0700")
Message-ID: <adahd0fl1tg.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 14 Aug 2006 16:27:55.0973 (UTC) FILETIME=[9916AF50:01C6BFBE]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Randy> Sure, autoconf.h is included, but I think his point is that
    Randy> CONFIG_WATCHDOG_NOWAYOUT may not be defined there at all,
    Randy> as in my 2.6.18-rc4 autoconf.h file, since my .config file
    Randy> says: # CONFIG_WATCHDOG_NOWAYOUT is not set

Huh?  How would including <linux/config.h> help with that?  And why
would you want CONFIG_WATCHDOG_NOWAYOUT to be defined if
WATCHDOG_NOWAYOUT is not set in your configuration?  That would
utterly break code that does something like

    #ifdef CONFIG_WATCHDOG_NOWAYOUT

 - R.
