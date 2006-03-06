Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751925AbWCFVuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbWCFVuS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbWCFVuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:50:17 -0500
Received: from mail.homelink.ru ([81.9.33.123]:12457 "EHLO eltel.net")
	by vger.kernel.org with ESMTP id S1751925AbWCFVuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:50:16 -0500
Date: Tue, 7 Mar 2006 00:07:18 +0300
From: Andrew Zabolotny <zap@homelink.ru>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: Backlight Class sysfs attribute behaviour
Message-Id: <20060307000718.0e8b8be3.zap@homelink.ru>
In-Reply-To: <1141634729.6524.14.camel@localhost.localdomain>
References: <1141571334.6521.38.camel@localhost.localdomain>
	<440B89AB.3020203@gmail.com>
	<1141634729.6524.14.camel@localhost.localdomain>
Organization: home
X-Mailer: Sylpheed version 2.0.0beta6 (GTK+ 2.6.7; i686-pc-linux-gnu)
X-Face: #%`a@cSvZ:n@M%n/to$C^!{JE%'%7_0xb("Hr%7Z0LDKO7?w=m~CU#d@-.2yO<l^giDz{>9
 epB|2@pe{%4[Q3pw""FeqiT6rOc>+8|ED/6=Eh/4l3Ru>qRC]ef%ojRz;GQb=uqI<yb'yaIIzq^NlL
 rf<gnIz)JE/7:KmSsR[wN`b\l8:z%^[gNq#d1\QSuya1(
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Mar 2006 08:45:28 +0000
Richard Purdie <rpurdie@rpsys.net> wrote:

> * the user supplied power sysfs attribute
> * the user supplied brightness sysfs attribute
> * the current FB blanking state
> * any other driver specific factors
As far I see the only real concern here is the console blanking. So why
not make it just another device state flag, which doesn't influence the
'power' attribute and which isn't visible from user space (what for?).
And the 'real' power state will be computed as "blank && power"
attributes. The entire logic could be hidden in backlight.c so that no
driver will have to be modified for this. Maybe a 'hw_power' or such
would be needed to see the 'real' hardware state (and possibly
modify, if you really really want to).

Is there any need for a broader-range solution here?

-- 
Greetings,
   Andrew
