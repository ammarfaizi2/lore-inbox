Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266114AbUHARhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266114AbUHARhr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 13:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266081AbUHARhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 13:37:46 -0400
Received: from relay1.eltel.net ([195.209.236.38]:39047 "EHLO relay1.eltel.net")
	by vger.kernel.org with ESMTP id S266170AbUHARhU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 13:37:20 -0400
Date: Sun, 1 Aug 2004 21:37:13 +0400
From: Andrew Zabolotny <zap@homelink.ru>
To: John Lenz <jelenz@wisc.edu>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: Backlight and LCD module patches [2]
Message-Id: <20040801213713.403d505b.zap@homelink.ru>
In-Reply-To: <20040731221736.GE5483@hydra.mshome.net>
References: <20040617223517.59a56c7e.zap@homelink.ru>
	<20040725215917.GA7279@hydra.mshome.net>
	<20040728221141.158d8f14.zap@homelink.ru>
	<20040729232547.GA4565@hydra.mshome.net>
	<20040730040645.169e4024.zap@homelink.ru>
	<20040730004950.GA11828@hydra.mshome.net>
	<20040731000205.4b0d8f01.zap@homelink.ru>
	<20040731221736.GE5483@hydra.mshome.net>
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

On Sat, 31 Jul 2004 17:17:36 -0500
John Lenz <jelenz@wisc.edu> wrote:

> I could see it going either way I guess.  The other thing the class_match
> could do is create those symlinks from the two classes of devices.  What
> other way is there from userspace to see which lcd device is associated with
> fb device?
Ok, you convinced me that a thin layer would give something. However, I
still think it would be better to use the lists that are already present in
class core, and not create new lists that duplicate the main one. First, the
main list is the 'ultimate' source of information, second list could
occasionally get out of sync.

> Yea I see that, but I was trying to keep all the class related code
> contained in class.c  I feel kinda uncomfortable manipulating lists and
> locking locks in struct class from outside code.
Well, *if* class_match will be implemented, it will become a part of class
core. So there shouldn't be a problem with manipulating that list.

> The way I see it, we really need a policy decision here, and neither you nor
> I are "authorized" to make that decision :)  We have two completly seperate
> devices, both have a struct device and both have a struct device_driver. 
> They can sit on completly seperate buses and be mixed together in lots of
> different combinations. One of the devices "knows" if it matches with the
> other device.
You did a perfect summary of the problem. Greg, what's your answer?

--
Greetings,
   Andrew
