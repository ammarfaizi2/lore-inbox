Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030273AbWARSos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbWARSos (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 13:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbWARSor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 13:44:47 -0500
Received: from mx01.qsc.de ([213.148.129.14]:12496 "EHLO mx01.qsc.de")
	by vger.kernel.org with ESMTP id S1030273AbWARSor convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 13:44:47 -0500
From: =?utf-8?q?Ren=C3=A9_Rebe?= <rene@exactcode.de>
Organization: ExactCODE
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: interrupt routing ATi RS480M (MSI Megabook S270)
Date: Wed, 18 Jan 2006 19:50:46 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <200601161607.24209.rene@exactcode.de> <20060118181421.11B0F21615@dungeon.inka.de>
In-Reply-To: <20060118181421.11B0F21615@dungeon.inka.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601181950.46352.rene@exactcode.de>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On Wednesday 18 January 2006 19:14, Andreas
	Jellinghaus wrote: > Check your bios revision. I had an irq routing
	issue too, > till I updated to the latest BIOS version. Now both 2.6.14
	plain > and 2.6.15 ubuntu are fine, while 2.6.15 plain still gives me >
	some error (happends when acpi is loaded and whole sysfs is scanned).
	[...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 18 January 2006 19:14, Andreas Jellinghaus wrote:
> Check your bios revision. I had an irq routing issue too,
> till I updated to the latest BIOS version. Now both 2.6.14 plain
> and 2.6.15 ubuntu are fine, while 2.6.15 plain still gives me
> some error (happends when acpi is loaded and whole sysfs is scanned).

Ack. I already replied to myself that the BIOS update cureed it.

> I'm using noapictimer option to keep the clock running at normal
> speed. without it runs at twice the normal speed.

the disable_timer_pin_1  option helps too. But with APIC my box does not reume 
and hangs after the suspend / resume cycle. With noapic I can suspend / 
resume weeks without a hazzle. With acpi_sleep=s3_bios even the text console 
comes back nicely. Though I mostly use X anyway. Only shutdown / reboot does 
not work after resume. I think the BIOS hangs after the associated ACPI call.

> btw: what are you using for graphics?
> with (k)ubuntu breezy / xorg 6.8 the ati proprietory fglrx was
> flickering a lot. So I updated to (k)ubuntu dapper / x.org 6.9
> and tried both the open source radeon and the fglrx, but both
> are very unstable, writing emails in kontakt kills them often.
>
> so now I'm using vesa x11 driver which is terrible slow (too slow
> for playing movies) and uses 1024x768 while the display is 1280x800,
> but at least it is stable and flickers nearly not.

Since I'm alergic to binary only stuff I did not gave fglrx much tries - did 
not work well anyway. I use X11R7 since the first release candidates 
accelerated 2D works fine with the radeon driver. No issues even with week 
long suspend resume cycles, that is it replaced my former Apple iBook G3 
completely.

Distribution is T2 (http://www.t2-project.org) with mostly trunk:HEAD running 
(that is modular anything).

Yours,

-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://www.exactcode.de | http://www.t2-project.org
            +49 (0)30  255 897 45
