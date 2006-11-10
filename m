Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946645AbWKJNnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946645AbWKJNnI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 08:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946647AbWKJNnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 08:43:08 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:10910 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1946645AbWKJNnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 08:43:05 -0500
Subject: Re: [Dumb question] 100k RTC interrupts/sec on SMP system: why?
From: Arjan van de Ven <arjan@infradead.org>
To: Paul P Komkoff Jr <i@stingr.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20061110133504.GC18001@stingr.net>
References: <20061109100953.GE2226@stingr.net>
	 <20061109204145.56d02153.akpm@osdl.org> <20061110123541.GA18001@stingr.net>
	 <1163163603.3138.700.camel@laptopd505.fenrus.org>
	 <20061110133504.GC18001@stingr.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 10 Nov 2006 14:43:02 +0100
Message-Id: <1163166183.3138.707.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-10 at 16:35 +0300, Paul P Komkoff Jr wrote:
> Replying to Arjan van de Ven:
> > Also have you tried acpi=off or the linux firmware test kit (see url in
> 
> acpi=off fixed this.
>   8:          1          0    IO-APIC-edge  rtc
acpi=on had this

>  8: 3673166897 3674697116   IO-APIC-level  rtc

spot the level-vs-edge difference.... your acpi interrupt routing looks
bust.


> So I got rid of "interrupt storm" but what I've lost (except poweroff)?

you can get power off with APM as well.

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

