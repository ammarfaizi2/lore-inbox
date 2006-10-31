Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422915AbWJaH7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422915AbWJaH7t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 02:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422799AbWJaH7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 02:59:49 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:36059 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1422915AbWJaH7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 02:59:48 -0500
Date: Tue, 31 Oct 2006 08:59:22 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Zachary Amsden <zach@vmware.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18 is problematic in VMware
In-Reply-To: <45463B7D.8050002@vmware.com>
Message-ID: <Pine.LNX.4.61.0610310857280.23540@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0610290953010.4585@yvahk01.tjqt.qr>
 <45463B7D.8050002@vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> I have observed a strange slowdown with the 2.6.18 kernel in VMware. This
>> happened both with the SUSE flavor and with the FC6 installer CD (which I
>> am trying right now). In both cases, the kernel "takes its time" after the
>> following text strings:
>> 
>> * Checking if this processor honours the WP bit even in supervisor mode...
>> Ok.
>> * Checking 'hlt' instruction... OK.
>> 
>> What's with that?
>
> Thanks.  It is perhaps the jiffies calibration taking a while because of the
> precise timing loop.  Are you reasonably confident that it is a regression in
> performance over 2.6.17?

Yes. I am not exactly sure if it's something in jiffies calibration 
(because of the 'WP bit/supervisor' thing too), so maybe I thought it 
was the newly-introduced SMP alternatives. I gotta check that.

> The boot sequence is pretty complicated, and a lot of
> it is difficult / slow to virtualize, so it could just be alternate timing
> makes the boot output appear to stall, when in fact the raw time is still about
> the same.  I will run some experiments.

Booting with 'time' shows that the virtual time increases as usual, i.e.

[ 9.00] checking if wp bit...
[15.00] next message here


	-`J'
-- 
