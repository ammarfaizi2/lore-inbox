Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbVKXOIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVKXOIx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 09:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbVKXOIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 09:08:53 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:52938 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1750756AbVKXOIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 09:08:52 -0500
Date: Thu, 24 Nov 2005 15:08:25 +0100
From: Daniel Nilsson <daniel.n.nilsson@home.se>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Markus.Lidel@shadowconnect.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Performance degradation when using partitions
Message-ID: <20051124140825.GA15298@oden.homeip.net>
References: <20051109182300.GA27452@oden.homeip.net> <43833DD9.2060108@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43833DD9.2060108@tmr.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 10:48:41AM -0500, Bill Davidsen wrote:
> Daniel Nilsson wrote:
> >While setting up a software RAID-5 array I started looking into the
> >performance aspect of using partioned drives versus the whole disks
> >for a RAID-5 array. I have an Adaptec 2400a controller which through
> >the I2O kernel driver gives me access to 4x 250GB disks (JBOD mode).
> 
> Did you get an answer on this? And does it happen if you use the drives 
> directly, /dev/hdN or /dev/sdN instead of using I2O? I didn't see an 
> obvious speed penalty in raw access of drives vs. partitions, but I 
> lacked the hardware to really match your setup, particularly the I2O use 
> vs. direct access to /dev/sd[ef].

Bill,

No, I didn't get an answer on this. I've done some more experiments
with the drives, but since they are connected to an Adaptec 2400A RAID
controller (in JBOD mode) I need to go through some I2O driver in or
to see the drives at all. So I never have direct access to these
drives as /dev/hdN or /dev/sdN. There are however two different
drivers available for this RAID controller, one is the standard I2O
driver and the other one is the Adaptec dpt_i2o driver.

The results are the same though whether I use the Linux I2O driver or
the Adaptec dpt_i2o, the software raid array is rebuilding at roughly
half the speed when the drives are partioned. I don't know what other
data to provide in ordet to get any further in the testing.

Thanks
Daniel
