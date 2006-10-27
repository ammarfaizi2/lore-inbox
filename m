Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946302AbWJ0KA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946302AbWJ0KA0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 06:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946306AbWJ0KA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 06:00:26 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:39557 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1946302AbWJ0KAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 06:00:25 -0400
Date: Fri, 27 Oct 2006 11:58:44 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Dick Streefland <dick.streefland@altium.nl>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       sam@ravnborg.org
Subject: Re: What about make mergeconfig ?
In-Reply-To: <Pine.LNX.4.62.0610261357080.1555@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.61.0610271154260.17570@yvahk01.tjqt.qr>
References: <3d6d.453f3a0f.92d2c@altium.nl> <1161755164.22582.60.camel@localhost.localdomain>
 <3d6d.453f3a0f.92d2c@altium.nl> <Pine.LNX.4.61.0610251336580.23137@yvahk01.tjqt.qr>
 <31ed.453f5399.96651@altium.nl> <Pine.LNX.4.61.0610261000210.29875@yvahk01.tjqt.qr>
 <Pine.LNX.4.62.0610261102520.1555@pademelon.sonytel.be>
 <Pine.LNX.4.61.0610261322120.29875@yvahk01.tjqt.qr>
 <Pine.LNX.4.62.0610261357080.1555@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> >What about RCS merge?
>> 
>> I take it we do not want to depend on too many tools (remember the 
>> kconfig implementation language debate).
>
>If you have CVS installed, you have RCS merge.

11:54 ichi:~ > rpm -q cvs rcs
cvs-1.12.12-19
package rcs is not installed

11:54 ichi:~ > gzip -cd /ARCHIVES.gz | grep "/merge$"
./CD1/suse/i586/rcs-5.7-879.i586.rpm:
    -rwxr-xr-x    1 root    root 45252 May  2 09:42 /usr/bin/merge

CVS does not need RCS.

>>>merge -p other.config .config.old .config > other.config.new
>> 
>> This also does not seem conflict-safe.
>
>Indeed, you can still have conflicts, which you have to resolve manually.
>
>But it depends on what you want to achieve: do you want to set each config
>option in the destination config to max(config1.option, config2.option), or do
>you want to apply the recent changes for one config (which may include
>disabling options) to another config?

In my case, the latter.

>For the latter, merge should work fine.

Is merge a lot different from what `patch` is doing?


	-`J'
-- 
