Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274990AbTHMNcY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 09:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275003AbTHMNcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 09:32:24 -0400
Received: from baloney.puettmann.net ([194.97.54.34]:16314 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S274990AbTHMNcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 09:32:22 -0400
Date: Wed, 13 Aug 2003 15:31:26 +0200
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 APM problems with IBM Thinkpad's
Message-ID: <20030813133126.GA26337@puettmann.net>
References: <20030813123119.GA25111@puettmann.net> <16186.14686.455795.927909@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16186.14686.455795.927909@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.4i
From: Ruben Puettmann <ruben@puettmann.net>
X-Scanner: exiscan *19mvio-0006tc-00*tDDbxtpUIAc* (Puettmann.NeT, Germany)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 03:13:02PM +0200, Mikael Pettersson wrote:
> 
> This sounds like a well-known APM/local-APIC clash.

nice to know ... 
> 
> Never ever use DISPLAY_BLANK if you also have SMP or UP_APIC.

not nice so ;-( how is it with acpi? Same problem?

> With APIC support enabled (SMP or UP_APIC), APM must be constrained:
> DISPLAY_BLANK off
> CPU_IDLE off
> built-in driver, not module

Why will this not be disabled in make *config so that nobody will run in
this problem?

> This is because the apm driver does BIOS calls, and many BIOSen
> (including the code in graphics cards, e.g. all Radeons it seems)
> like to hang if a local APIC timer interrupt arrives.

Yes radeonfb don't like apm -s on this thinkpad. apm -s works but on
resume it freezed some on

modprobe radeonfb;
sleep 10;
rmmod radeonfb;
sleep 10;
modprobe radeonfb;

and thinkpad freezed .


            Ruben

-- 
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net
