Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751993AbWJZIBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbWJZIBB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 04:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752034AbWJZIBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 04:01:01 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:34211 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751993AbWJZIBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 04:01:00 -0400
Date: Thu, 26 Oct 2006 10:00:41 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Dick Streefland <dick.streefland@altium.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: What about make mergeconfig ?
In-Reply-To: <31ed.453f5399.96651@altium.nl>
Message-ID: <Pine.LNX.4.61.0610261000210.29875@yvahk01.tjqt.qr>
References: <3d6d.453f3a0f.92d2c@altium.nl> <1161755164.22582.60.camel@localhost.localdomain>
 <3d6d.453f3a0f.92d2c@altium.nl> <Pine.LNX.4.61.0610251336580.23137@yvahk01.tjqt.qr>
 <31ed.453f5399.96651@altium.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>| >Can't you do that with just a sort command?
>| >
>| >  sort .config other.config > new.config
>| 
>| That does not work where .config and other.config have the same symbol 
>| listed, kconfig will bark and use the first value encountered. Because I 
>| do have exactly that problem with my patch series (changes some Ys to 
>| Ms), I am in need of the following patch to Kconfig TDTRT.
>
>Or you can use the following hack:
>
>  (sort .config other.config; echo set) | sh | grep ^CONFIG_ > new.config

That does not properly deal with "# CONFIG_XYZ is not set" lines in 
other.config.


	-`J'
-- 
