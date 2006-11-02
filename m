Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752609AbWKBASl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbWKBASl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 19:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752610AbWKBASl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 19:18:41 -0500
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:39055 "EHLO
	rhlx01.hs-esslingen.de") by vger.kernel.org with ESMTP
	id S1752609AbWKBASk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 19:18:40 -0500
Date: Thu, 2 Nov 2006 01:18:39 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required) [2.6.18-rc4-mm1]
Message-ID: <20061102001838.GA911@rhlx01.hs-esslingen.de>
References: <20061101140729.GA30005@rhlx01.hs-esslingen.de> <1162417916.15900.271.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <1162417916.15900.271.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Nov 01, 2006 at 10:51:56PM +0100, Thomas Gleixner wrote:
> On Wed, 2006-11-01 at 15:07 +0100, Andreas Mohr wrote:
> > x86 UP Athlon 1200, VIA chipset.
> > 
> > Probably some problem with VIA chipsets and APIC, PIT, ...?
> > 
> > Would be nice to get this to work properly, anything I should try to debug?
> 
> Can you try:
> 
> http://tglx.de/projects/hrtimers/2.6.19-rc4-mm1/patch-2.6.19-rc4-mm1-hrt-dyntick1.patch

You applied a nice lameness filter, by secretly making sure that -dyntick1
is unavailable and a new -dyntick2 took its place, right? ;)

> on top of -mm please? Can you mail me a boot log of that ?

Attached (went the extra mile and made sure to reply this night already).

It seems we have C2 APIC issues here, from a cursory glance at the log...

Note that it stalls directly after the
input: AT Translated Set 2 keyboard as /class/input/input0
line (from that point on it needs additional "support" via keyboard press).

Don't tell me my chipset is so awfully buggy that the best thing would be
to swap mainboards immediately...

Thanks!!
(especially for your nice dynticks work)

Andreas Mohr

--LZvS9be/3tNcYl/X
Content-Type: application/x-gzip
Content-Disposition: attachment; filename="dmesg.log.gz"
Content-Transfer-Encoding: base64

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
wUM8AAA=

--LZvS9be/3tNcYl/X--
