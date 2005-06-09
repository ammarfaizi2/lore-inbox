Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262342AbVFIKmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbVFIKmm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 06:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVFIKmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 06:42:42 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30690 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262342AbVFIKmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 06:42:33 -0400
Date: Thu, 9 Jun 2005 12:42:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "David S. Miller" <davem@davemloft.net>
Cc: vda@ilport.com.ua, abonilla@linuxwireless.org, jgarzik@pobox.com,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       ipw2100-admin@linux.intel.com
Subject: Re: ipw2100: firmware problem
Message-ID: <20050609104205.GD3169@elf.ucw.cz>
References: <002901c56c3b$8216cdd0$600cc60a@amer.sykes.com> <200506090909.55889.vda@ilport.com.ua> <20050608.231657.59660080.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608.231657.59660080.davem@davemloft.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Currently, when we install the driver, it associates to any open network on
> > > boot. This is good, cause we don't want to be typing the commands all the
> > > time just to associate. It works this way now and is pretty nice.
> > 
> > What is so nice about this? That Linux novice user with his new lappie
> > will join a neighbor's network every time he powers up the lappie,
> > even without knowing that?
> 
> I love this behavior, because it means that I don't have to do
> anything special to get my setup at home working.
> 
> Me caveman
> Me plug in wireless router
> Me watch pretty lights
> Me turn on computer
> Me up interface
> Computer work
> Me no care other cavemen use wireless link
> 
> Configuration knobs are _madness_.  Things should work with minimal
> intervention and configuration.

I'm not saying it should not work automagically. But it is wrong to
start transmitting on wireless as soon as kernel boots. It should stay
quiet in the radio until it is either told to talk or until interface
is upped.

That way 

* above still works, only radio chat begins one step later

* if you are in environment where you absolutely do not want it to
talk on the radio (airplane, BlackHatCon with APs trying to hack you
all around), you can make it quiet without needing kernel/module
parameters.

								Pavel 
