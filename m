Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbVCXHPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbVCXHPH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 02:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVCXHPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 02:15:07 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:54458 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S263071AbVCXHIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 02:08:00 -0500
Date: Thu, 24 Mar 2005 08:07:55 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Natanael Copa <mlists@tanael.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: forkbombing Linux distributions
In-Reply-To: <1111590294.27969.114.camel@nc>
Message-ID: <Pine.LNX.4.61.0503240805110.19487@yvahk01.tjqt.qr>
References: <e0716e9f05032019064c7b1cec@mail.gmail.com>  <20050322112628.GA18256@roll>
  <Pine.LNX.4.61.0503221247450.5858@yvahk01.tjqt.qr>  <20050322124812.GB18256@roll>
 <20050322125025.GA9038@roll>  <9cde8bff050323025663637241@mail.gmail.com>
 <1111581459.27969.36.camel@nc>  <9cde8bff05032305044f55acf3@mail.gmail.com>
 <1111586058.27969.72.camel@nc>  <Pine.LNX.4.61.0503231543030.10048@yvahk01.tjqt.qr>
 <1111590294.27969.114.camel@nc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >brings down almost all linux distro's while other *nixes survives.
>> 
>> Let's see if this can be confirmed.
>
>open/free/netbsd survives. I guess OSX does too.

Confirmed. My OpenBSD install copes very well with forkbombs.
However, I _was able_ to spawn a lot of shells by default.
The essence is that the number of processes/threads within
a _session group_ (correct word?) is limited. That way, you can
start a ton of "/bin/sh"s from one another, i.e.:

 \__ login jengelh
     \__ /bin/sh
         \__ /bin/sh
             \__ /bin/sh
...

So I think that if you add a setsid() to your forkbomb,
you could once again be able to bring a system - BSD this time - down.
Just a guess at this time, I would need to write a prog first :p



Jan Engelhardt
-- 
