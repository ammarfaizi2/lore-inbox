Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263259AbTDRVdE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 17:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbTDRVdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 17:33:04 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:32416 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S263259AbTDRVdD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 17:33:03 -0400
To: linux-kernel@vger.kernel.org
Cc: Dave Jones <davej@codemonkey.org.uk>, Jurriaan <thunder7@xs4all.nl>,
       Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>
Subject: Re: My P3 runs at.... zero Mhz (bug rpt)
References: <20030418211147.GA1225@suse.de>
X-URL: http://www.fi.muni.cz/~pekon/
From: Petr Konecny <pekon@informatics.muni.cz>
Date: 18 Apr 2003 23:44:53 +0200
In-Reply-To: <20030418211147.GA1225@suse.de>
Message-ID: <qwwvfxb1nvu.fsf@decibel.fi.muni.cz>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Dave Jones (Dave) said:

 Dave> On Fri, Apr 18, 2003 at 06:44:54AM +0200, Jurriaan wrote:
 >> From: Jeff Garzik <jgarzik@pobox.com>
 >> Date: Thu, Apr 17, 2003 at 10:10:53PM -0400
 >> > Just booted into 2.5.67-BK-latest (plus my __builtin_memcpy patch). 
 >> > Everything seems to be running just fine, so naturally one must nitpick 
 >> > little things like being told my CPU is running at 0.000 Mhz.  :)
 >> > 
 >> fwiw, my Athlon XP2400 does the same in 2.5.67-ac1:
 >> 
 >> processor	: 0
 >> vendor_id	: AuthenticAMD
 >> cpu family	: 6
 >> model		: 8
 >> model name	: AMD Athlon(tm) XP 2400+
 >> stepping	: 1
 >> cpu MHz		: 0.000
 >> cache size	: 256 KB
 >> bogomips	: 1970.17


 Dave> Curious. Do either of you have any cpufreq bits enabled?
 Dave> If so, does it go away if you disable them?
 Dave> That frobs with cpu_khz, so it *could* be not initialising
 Dave> it someplace.  Especially if your hardware turns out to be
 Dave> unsupported by any of the cpufreq backend drivers..
It does not help me with 2.5.67-ac2 + pcmcia patch. I get 0.000 MHz,
589.82 BogoMIPS with or without CPUFreq. It did the same thing with
2.5.67-ac1 (did not test w/o CPUFreq).

The box is 600 MHz PIII (Coppermine) in Dell Inspiron 5000. On the plus
side I kind of like the # of insns per clock cycle ;-)

As Jeff said it's almost OK otherwise; it hangs on boot without the
pcmcia patch and I saw USB Storage oopses.

                                                Petr
