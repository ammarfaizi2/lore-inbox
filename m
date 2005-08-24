Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbVHXJrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVHXJrb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 05:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbVHXJrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 05:47:31 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:59063 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750711AbVHXJrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 05:47:31 -0400
Date: Wed, 24 Aug 2005 11:47:12 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
cc: Nishanth Aravamudan <nacc@us.ibm.com>, benh@kernel.crashing.org,
       Anton Blanchard <anton@samba.org>, frank@tuxrocks.com,
       George Anzinger <george@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
In-Reply-To: <430C312D.21770.54E50A3@rkdvmks1.ngate.uni-regensburg.de>
Message-ID: <Pine.LNX.4.61.0508241056090.3728@scrub.home>
References: <1124838847.20617.11.camel@cog.beaverton.ibm.com>
 <430C312D.21770.54E50A3@rkdvmks1.ngate.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 24 Aug 2005, Ulrich Windl wrote:

> I'm having a problem with your wording: NTP _does_ control the "system time" 
> (system clock), because it's the only clock it can use. The "reference time" is 
> usually remote or elsewhere (multiple sources). Local NTP does not control the 
> remote reference time(s).

I'm open to better wording suggestions, but this is from the kernel 
perspective and ntp daemon has as much control over the kernel time as the 
remote server has control over the ntp daemon (and basically also the 
other way around). Every entity has its own idea of time and uses 
something else as reference. The ntp daemon uses the remote server as 
reference time and the kernel gets from a ntp daemon a reference time. The 
kernel can now either just jump in regular intervals to that reference 
time or it modifies the speed of the system time to keep close to it.
It's really the kernel who modifies the system clock based on the 
parameters from the ntp daemon.

bye, Roman
