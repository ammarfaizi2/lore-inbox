Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264365AbUBRLFU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 06:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbUBRLFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 06:05:19 -0500
Received: from gate.crashing.org ([63.228.1.57]:12965 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264365AbUBRLFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 06:05:12 -0500
Subject: Re: Radeonfb problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Damian Kolkowski <damian@kolkowski.no-ip.org>
Cc: Kronos <kronos@kronoz.cjb.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Sergio Vergata <vergata@stud.fbi.fh-darmstadt.de>
In-Reply-To: <20040218102613.ALLYOURBASEAREBELONGTOUS.A2246@kolkowski.no-ip.org>
References: <200402172008.39887.vergata@stud.fbi.fh-darmstadt.de>
	 <20040217203604.GA19110@dreamland.darkstar.lan>
	 <20040217211120.ALLYOURBASEAREBELONGTOUS.A8392@kolkowski.no-ip.org>
	 <20040217213441.GA22103@dreamland.darkstar.lan>
	 <20040217215738.ALLYOURBASEAREBELONGTOUS.B9706@kolkowski.no-ip.org>
	 <1077056532.1076.27.camel@gaston>
	 <20040218102613.ALLYOURBASEAREBELONGTOUS.A2246@kolkowski.no-ip.org>
Content-Type: text/plain
Message-Id: <1077102104.20787.3.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 18 Feb 2004 22:01:45 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> if I use fbset like this:
> 
> 	fbset -fb /dev/fb0 -a -depth 32 1024x768-100
> 
> my CRT monitor MAG 786FD looks like ths:
> 
> |------------|
> |     |      |
> |  a  |      |
> |     |      |
> |-----|      |
> |       b    |
> |            |
> |------------|
> 
> Where "a" is the visual screan after using fbset and "b" is my monitor.

Ok, I see what you mean. This is not a radeonfb problem at this point.

The problem is in the fbcon layer in 2.6 which doesn't adapt to
resolution changes. I have done some work to fix this but it's
not completely right yet. I'll submit something to Andrew & Linus
once I'm happy with it.

The append= you need is radeonfb=, not radeon=

I don't think the cursor issue is related at all. And I don't know
what's up with the firegl binary drivers.

Ben.

