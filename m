Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWAPSbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWAPSbg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 13:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWAPSbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 13:31:36 -0500
Received: from mx02.qsc.de ([213.148.130.14]:45958 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S1751077AbWAPSbf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 13:31:35 -0500
From: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Organization: ExactCODE
To: linux-kernel@vger.kernel.org
Subject: Re: interrupt routing ATi RS480M (MSI Megabook S270)
Date: Mon, 16 Jan 2006 19:31:52 +0100
User-Agent: KMail/1.9
References: <200601161607.24209.rene@exactcode.de>
In-Reply-To: <200601161607.24209.rene@exactcode.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601161931.52539.rene@exactcode.de>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, since it is usually what I touch last, I now tried
	an BIOS update which solved the IRQ routing oddities: old version: V3.20
	06/27/05 new version: V4.30 10/01/06 [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

since it is usually what I touch last, I now tried an BIOS update which solved 
the IRQ routing oddities:

old version:  V3.20 06/27/05
new version: V4.30 10/01/06

The 2x timer sped can be circumvented with: disable_timer_pin_1

However then, with APIC interrupts used, the machine does not come back 
properly after suspend, it hangs on resume. I can post the debug output of 
that if someone is interested.

On Monday 16 January 2006 16:07, I wrote:

> I have a MSI Megabook S270 with AMD Turion MT-30 and the interrupt routing
> never worked quite right. I'll describe the problems with 2.6.15, since I
> reinstalled the system recently and do not have older kernels to quote logs
> for those.
>
> First I have to boot with e.g. noapic, otherwise the system time runs twice
> as fast but with and without noapic. pci=routeirq, pci=assign-busses or
> irqpoll the interrupt assigned to the USB controllers gets disabled and
> thus renders USB unfunctional.
>
> Attached are dmesg and /proc/interrupts of 2.6.15 once vanilla and once
> with noapic. Just drop a note if more information, option or patch to test
> is welcome:

-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://www.exactcode.de | http://www.t2-project.org
            +49 (0)30  255 897 45
