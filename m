Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263832AbUAEMSb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 07:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUAEMSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 07:18:31 -0500
Received: from hell.org.pl ([212.244.218.42]:17930 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S263832AbUAEMSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 07:18:30 -0500
Date: Mon, 5 Jan 2004 13:18:30 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjanv@redhat.com>, jw schultz <jw@pegasys.ws>
Subject: Re: [2.6.0-mm2] PM timer still has problems
Message-ID: <20040105121830.GA12521@hell.org.pl>
References: <20031230204831.GA17344@hell.org.pl> <20031230200249.107b56f0.akpm@osdl.org> <20040104004449.GA20647@hell.org.pl> <200401050117.06681.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <200401050117.06681.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Dmitry Torokhov:
> I threw a monkey wrench in timer code and came up with the patch below...
> It is not intended for inclusion as is, just some work in progress.
> 
> I decided to go hpet way and use tsc in ACPI PM timer to do delay stuff
> and monotonic clock. Plus there some code rearrangements, and stuff I grabbed
> from the CPUFREQ list (Dominics + Li Shahoua P4 variable tsc info ), etc...
> If there is an interest I can split the code into smaller chinks. For what
> it worth I am running with ACPI PM timer, CPUFREQ (dynamically switching
> frequency based on load) and Synaptics and everything is calm. Ntpd has also
> stopped complaining about loosing sync...

Well, no luck here. When clock=pmtmr is appended, the system hangs just
after printing:
#v+
Warning: clock= override failed. Defaulting to PIT
Using pit for high-res timesource
Detected 1700.598 MHz processor.
Console: colour VGA+ 80x25
#v-

The system boots fine without the clock= parameter, though.
[it's an ASUS L3800C laptop with a P4-M and 2.6.1-rc1-mm1 with your patch
on top]

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
