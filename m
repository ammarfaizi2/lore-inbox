Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265546AbUBBNvV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 08:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265594AbUBBNvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 08:51:21 -0500
Received: from genesis.westend.com ([212.117.67.2]:56504 "EHLO
	genesis.westend.com") by vger.kernel.org with ESMTP id S265546AbUBBNvT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 08:51:19 -0500
Subject: Re: Where do the "Machine Check Exceptions" come from? [update]
From: Kai Militzer <km@westend.com>
To: linux-kernel@vger.kernel.org
Cc: Kai Militzer <km@westend.com>
In-Reply-To: <1075370497.775.89.camel@bart>
References: <1075370497.775.89.camel@bart>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.5 
Date: 02 Feb 2004 14:51:32 +0100
Message-Id: <1075729900.777.40.camel@bart>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone!

I have an update on the reproduction of the strange kernel oopses on an
2.4.24 kernel.

> It all started, that the machine crashed in two-day-intervalls with the
> following message in log:

> Jan  6 22:39:01 CPU 0: Machine Check Exception: 0000000000000004
> Jan  6 22:39:01 Bank 4: b200000000040151
> Jan  6 22:39:01 Kernel panic: CPU context corrupt

That's the message, that always appears.

We then tested around as described in my original mail.

> So there must be something else. Next step was to take the config from
> the 2.4.19 kernel and do a "make oldconfig" with the 2.4.24. The system
> is now running for two days without a crash. So it must be something
> that has changed between the two configs.

The kernel ran for four days without crashing. So I tried to activate
some options, that were activeted in the crashing kernel.

I started with this option, just by a foresought.

> < CONFIG_DEBUG_STACKOVERFLOW=y
> ---
> > # CONFIG_DEBUG_STACKOVERFLOW is not set

It was not set in the kernel running for four days, but in the one,
crashing. After I activated it (means: CONFIG_DEBUG_STACKOVERFLOW=y),
compiled the kernel and let it run under work for the weekend (starting
on friday). This morning (monday) it crashed. So I would say, it was the
CONFIG_DEBUG_STACKOVERFLOW.

Does anyone have an idea, why this options makes the kernel crash?
Shouldn't this option prevent the kernel from crashing?

If more information is needed (i.e. full kernel config, hardware specs,
etc.) please let me know.

Regards

Kai

-- 
Kai Militzer                 WESTEND GmbH  |  Internet-Business-Provider
Technik                      CISCO Systems Partner - Authorized Reseller
                             Lütticher Straße 10      Tel 0241/701333-11
km@westend.com               D-52064 Aachen              Fax 0241/911879


