Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbVAOQxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbVAOQxX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 11:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbVAOQxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 11:53:23 -0500
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:33802 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262298AbVAOQxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 11:53:19 -0500
Date: Sat, 15 Jan 2005 17:55:45 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Simone Piunno <pioppo@ferrara.linux.it>
Cc: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>, "Greg KH" <greg@kroah.com>,
       "Jonas Munsin" <jmunsin@iki.fi>, djg@pdp8.net
Subject: Re: 2.6.10-mm2: it87 sensor driver stops CPU fan
Message-Id: <20050115175545.743a39f9.khali@linux-fr.org>
In-Reply-To: <200501151654.46412.pioppo@ferrara.linux.it>
References: <g7Idbr9m.1105713630.9207120.khali@localhost>
	<200501151654.46412.pioppo@ferrara.linux.it>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simone,

> > 2* In the logs, you should see an information line with the chip
> > type, address and revision.
> > 3* Still in the logs, you should see a warning about your BIOS being
> > broken and PWM being disabled as a consequence.
> 
> Confirmed, but it looks like there's a missing linefeed in the
> warning.
> 
> pioppo@roentgen ~ $ uname -a
> Linux roentgen 2.6.11-rc1-mm1 #1 Sat Jan 15 16:23:34 CET 2005 x86_64
> AMD  Athlon(tm) 64 Processor 3200+ AuthenticAMD GNU/Linux
> pioppo@roentgen ~ $ dmesg|grep it87
> it87: Found IT8705F chip at 0x290, revision 2
> it87 0-0290: detected broken BIOS defaults, disabling pwm
> interface<6>8139too  Fast Ethernet driver 0.9.27

True. The additional patch I posted earlier today fixes it though. You
can now test this one, which adds the "fix_pwm_polarity" module
parameter which will let you - at last - to use PWM the way it is meant
to be.

Let us know how it goes! :)

-- 
Jean Delvare
http://khali.linux-fr.org/
