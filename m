Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265959AbUAEWTq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 17:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265958AbUAEWSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 17:18:42 -0500
Received: from hell.org.pl ([212.244.218.42]:260 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S265959AbUAEWRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 17:17:53 -0500
Date: Mon, 5 Jan 2004 23:17:58 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-mm2] PM timer still has problems
Message-ID: <20040105221758.GA13727@hell.org.pl>
References: <20031230204831.GA17344@hell.org.pl> <1073340716.15645.96.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <1073340716.15645.96.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote john stultz:
> If the override boot option failed, its most likely your system doesn't
> have an ACPI PM time source.  Instead it seems your system is having

Well, I don't have the slightest idea on how to determine this, though I
read somewhere that all ACPI-compliant systems have those.

> trouble using the PIT as a time source (which seems not all that
> uncommon unfortunately). 

Perhaps, though bear in mind it behaves so only if clock=pmtmr has been
appended and works fine with clock=pit.

> I guess we can just re-call select_timer() without an override if the
> override fails, that way you'll fall back to the default time source on
> your system. Try the (compile tested) patch below and see if that helps.

That would be PIT again, as TSC is unusable due to CPUFreq.
I'll try it ASAP -- should I test with Dmitry's patch applied?
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
