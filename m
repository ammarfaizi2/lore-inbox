Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUG1SLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUG1SLv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 14:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUG1SLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 14:11:51 -0400
Received: from mail.homelink.ru ([81.9.33.123]:25284 "EHLO eltel.net")
	by vger.kernel.org with ESMTP id S261610AbUG1SLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 14:11:43 -0400
Date: Wed, 28 Jul 2004 22:11:41 +0400
From: Andrew Zabolotny <zap@homelink.ru>
To: John Lenz <jelenz@students.wisc.edu>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Backlight and LCD module patches [2]
Message-Id: <20040728221141.158d8f14.zap@homelink.ru>
In-Reply-To: <20040725215917.GA7279@hydra.mshome.net>
References: <20040617223517.59a56c7e.zap@homelink.ru>
	<20040725215917.GA7279@hydra.mshome.net>
Organization: home
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: #%`a@cSvZ:n@M%n/to$C^!{JE%'%7_0xb("Hr%7Z0LDKO7?w=m~CU#d@-.2yO<l^giDz{>9
 epB|2@pe{%4[Q3pw""FeqiT6rOc>+8|ED/6=Eh/4l3Ru>qRC]ef%ojRz;GQb=uqI<yb'yaIIzq^NlL
 rf<gnIz)JE/7:KmSsR[wN`b\l8:z%^[gNq#d1\QSuya1(
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jul 2004 16:59:17 -0500
John Lenz <jelenz@students.wisc.edu> wrote:

> The problem I see is that we would like something like a bus to match  
> together class devices.  What would be really nice is something like  
> this.
This is impossible to do in a device-independent way. Only the drivers know
how they can recognize each other. And if you're meaning the b/l driver will
register the match function with the core, that's very similar to the solution
I've described in my earlier messages.

> Lastly, wouldn't it be better to create a drivers/video/lcd directory  
> so that all the lcd drivers can go in there and not clutter up the main  
> drivers/video directory?
I agree but my word means nothing.

Speaking of your patch, I don't like the lcd_power_names array. The reason for
the 0-4 power status was to match that of VESA power states (0..4,
intermediate values mean intermediate power states, whatever they mean for
concrete devices). Besides, it makes end-user usage more complex (instead of
just specifying a number in the 0-4 range you now have to *know* you have to
specify "full off" and alike). Also it doesn't handle backlight, only LCD.

--
Greetings,
   Andrew
