Return-Path: <linux-kernel-owner+w=401wt.eu-S1751172AbXAFECK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbXAFECK (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 23:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbXAFECK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 23:02:10 -0500
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:36142 "HELO
	smtp106.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751169AbXAFECI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 23:02:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=6w3Ulz0vJgBjy9q+I6yO2KiGU0KAuK6Csj1ebsyiGymmMJTs+Q4UB2h2N6h2Wnn/j2xNBXeEfBNpaOcpKs/bg+G3p71F7uXazFasRHRscy45C5a+52Vu6Ew3sIqaIZ0UR6x33obTMdfZrq/Bb8YfydovOZYkfOl5r/+EnLqq1U4=  ;
X-YMail-OSG: atExBdgVM1ndodQ_wBlXVGOD2EVb.pO4649k1MOp1ueSZFLPzt2ZdDm2fseclrhh6pbcHfzdEJeg3jQfS4WX8eYaAeGTlA.2LUD3UelrFMA4z0XS0AOuHbCg3y62tsVSGfpi0IO3KdR7pc3JIB5uxCAhp8OMZdUOheRGEkc5q2PdykdEEQQ4MhNK9d.l
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [patch 2.6.20-rc3 1/3] rtc-cmos driver
Date: Fri, 5 Jan 2007 19:33:25 -0800
User-Agent: KMail/1.7.1
Cc: rtc-linux@googlegroups.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       Woody Suwalski <woodys@xandros.com>
References: <200701051001.58472.david-b@pacbell.net> <20070105214509.12190340@inspiron> <200701051910.02975.david-b@pacbell.net>
In-Reply-To: <200701051910.02975.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200701051933.26368.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 January 2007 7:10 pm, David Brownell wrote:
> On Friday 05 January 2007 12:45 pm, Alessandro Zummo wrote:

> >  I'd appreciate if someone (Woody?) can test
> >  this code on ARM.
> 
> There are PPC, M68K, SPARC, and other boards that could also
> use this; ARMs tend to integrate some other RTC on-chip.  But
> on whatever non-PC platform is involved in such sanity testing,
> that involves adding a platform_device to board setup code.

Let me put that differently.  That should be done as a separate
patch, adding (a) that platform_device, and maybe platform_data
if it's got additional alarm registers, and (b) Kconfig support
to let that work.  I'd call it a "patch #4 of 3".  ;)

The current Kconfig uses:

> +config RTC_DRV_CMOS
> +       tristate "CMOS real time clock"
> +       depends on RTC_CLASS && (X86_PC || ACPI)

Eventually maybe the PC-or-ACPI stuff should vanish, but IMO
not until this code has been used on a few other platforms.

- Dave
