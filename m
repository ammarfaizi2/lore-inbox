Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264337AbUDORJq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 13:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264354AbUDORJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:09:45 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:61922 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S264337AbUDORJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:09:42 -0400
From: Christian =?iso-8859-1?q?Kr=F6ner?= 
	<christian.kroener@tu-harburg.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IO-APIC on nforce2 [PATCH]
Date: Thu, 15 Apr 2004 19:09:40 +0200
User-Agent: KMail/1.6.1
Cc: Len Brown <len.brown@intel.com>, ross@datscreative.com.au,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
References: <200404131117.31306.ross@datscreative.com.au> <1081988224.15062.75.camel@dhcppc4> <200404151148.53187.ross@datscreative.com.au>
In-Reply-To: <200404151148.53187.ross@datscreative.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404151909.40636.christian.kroener@tu-harburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 April 2004 10:17, Len Brown wrote:
>  I'm okay putting the bootparam and the workaround into the kernel,
>  for it is generic and we may find other platforms need it.

Thats more than what I could have expected, thanks.


Ross, I tested my kernel with nmi_watchdog=1 and nmi_watchdog=2 getting only 2 
to work.

output: nmi_watchdog=1

activating NMI Watchdog ... done.
testing NMI watchdog ... CPU#0: NMI appears to be stuck!


output: nmi_watchdog=2

testing NMI watchdog ... OK.


This is on 2.6.5-mm5-1.

Concerning the timer, well I tested it against my radio-controlled clock, 
setting it with ntpdate first and letting the system run (with ntpd off) and 
my system is kinda faster than my radio-clock. After about one hour my system 
was off by +14s compared to the radio-clock. I don't know if that is pretty 
shitty or simply normal for these bad pc-clocks...

I'm now compiling 2.6.6-rc1 with the nmi_watchdog=1 workaround. One question 
about the C1idle-patch, does this add a new feature or is it just a 
workaround for locked up nforce2-systems (since I never experienced lockups 
on my system, I wouldn't need it then)?

thanks for now, christian.
