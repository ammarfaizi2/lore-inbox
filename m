Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752144AbWJZL1C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbWJZL1C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 07:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752146AbWJZL1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 07:27:02 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:22673 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1752144AbWJZL1A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 07:27:00 -0400
Date: Thu, 26 Oct 2006 13:25:26 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Dick Streefland <dick.streefland@altium.nl>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       sam@ravnborg.org
Subject: Re: What about make mergeconfig ?
In-Reply-To: <Pine.LNX.4.62.0610261102520.1555@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.61.0610261322120.29875@yvahk01.tjqt.qr>
References: <3d6d.453f3a0f.92d2c@altium.nl> <1161755164.22582.60.camel@localhost.localdomain>
 <3d6d.453f3a0f.92d2c@altium.nl> <Pine.LNX.4.61.0610251336580.23137@yvahk01.tjqt.qr>
 <31ed.453f5399.96651@altium.nl> <Pine.LNX.4.61.0610261000210.29875@yvahk01.tjqt.qr>
 <Pine.LNX.4.62.0610261102520.1555@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >Or you can use the following hack:
>> >
>> >  (sort .config other.config; echo set) | sh | grep ^CONFIG_ > new.config
>> 
>> That does not properly deal with "# CONFIG_XYZ is not set" lines in 
>> other.config.
>
>What about RCS merge?

I take it we do not want to depend on too many tools (remember the 
kconfig implementation language debate).

>merge -p other.config .config.old .config > other.config.new

This also does not seem conflict-safe.


	-`J'
-- 
