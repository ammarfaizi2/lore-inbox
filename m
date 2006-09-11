Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWIKFv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWIKFv6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 01:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWIKFv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 01:51:57 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:43977 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S964887AbWIKFv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 01:51:56 -0400
Date: Mon, 11 Sep 2006 09:50:53 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Samuel Tardieu <sam@rfc1149.net>,
       Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
Subject: Re: [PATCH] watchdog: add support for w83697hg chip
Message-ID: <20060911055053.GB18907@2ka.mipt.ru>
References: <87fyf5jnkj.fsf@willow.rfc1149.net> <1157815525.6877.43.camel@localhost.localdomain> <20060909220256.d4486a4f.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060909220256.d4486a4f.vsu@altlinux.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 11 Sep 2006 09:50:55 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On Sat, Sep 09, 2006 at 10:02:56PM +0400, Sergey Vlasov (vsu@altlinux.ru) wrote:
> I can find at least two attempts to fix the SuperIO problem:
> 
>   - a SuperIO subsystem proposed by Evgeniy Polyakov (cc'd);
> 
>   - a simple SuperIO locks coordinator proposed by Jim Cromie (also
>     cc'd; http://thread.gmane.org/gmane.linux.drivers.sensors/10052 -
>     can't find actual patches).
> 
> However, the mainline kernel still does not have anything for proper
> SuperIO access locking.

I created SuperIO subsystem for soekris board initially.
Later it was extended to support scx200/scx100 gpio (for w1 subsytem).
There is support for acb(i2c) bus, GPIO, and some stub for other
elements in pc8736x superIO chip.
But I was told those days (about at least 1.5 years ago) in lm_sensors 
mail list that splitting all that functionality into separated modules 
is the way to go.

As far as I recall pc8736x GPIO was added recently.

Here is one of the implementations posted to lm_sensors@:
http://archives.andrew.net.au/lm-sensors/msg27895.html

And here is my drawing board with image of how it looks (just for pure
interest) in my mind :) :
http://tservice.net.ru/~s0mbre/old/?section=gallery&item=superio_design

-- 
	Evgeniy Polyakov
