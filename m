Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262169AbVAKUyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbVAKUyY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 15:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbVAKUyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 15:54:24 -0500
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:17670 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262169AbVAKUyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 15:54:18 -0500
Date: Tue, 11 Jan 2005 21:56:33 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Jonas Munsin <jmunsin@iki.fi>, Simone Piunno <pioppo@ferrara.linux.it>
Cc: sensors@Stimpy.netroedge.com, djg@pdp8.net,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: 2.6.10-mm2: it87 sensor driver stops CPU fan
Message-Id: <20050111215633.3c2c08ea.khali@linux-fr.org>
In-Reply-To: <20050111202437.GA2914@nemo.sby.abo.fi>
References: <200501102341.44949.pioppo@ferrara.linux.it>
	<YN0o4rkI.1105435582.0805630.khali@localhost>
	<20050111202437.GA2914@nemo.sby.abo.fi>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, thanks for doing the thinking ;), here is the modified patch
> (it87.c_2.6.10-jm3-corrected_manual_pwm_20050111.diff). In addition to
> the above change, it also refreshes fan_main_ctrl in the update
> routine, as suggested by Jean on IRC.
> 
>  - adds manual PWM
>  - removes buggy "reset" module parameter
>  - fixes some whitespaces

Tested, works as intended for me.

Simone, you might revert
  http://khali.linux-fr.org/devel/i2c/linux-2.6/linux-2.6.10-rc3-i2c-it87-manual-pwm.diff
and apply this new patch instead. This won't solve the polarity issue
but at least the fans won't stop when you load the it87 driver.

We can now move to the second part of the plan. Stay tuned :)

-- 
Jean Delvare
http://khali.linux-fr.org/
