Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267645AbUHZFcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267645AbUHZFcM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 01:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267664AbUHZFcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 01:32:12 -0400
Received: from mail006.syd.optusnet.com.au ([211.29.132.63]:2537 "EHLO
	mail006.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267645AbUHZFcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 01:32:09 -0400
References: <A850C6B3EB02F044907B475259FFF56501724A18@jsc-mail08.jsc.nasa.gov>
Message-ID: <cone.1093498322.335520.27013.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: =?ISO-8859-1?B?SE9MVFos?= CORBIN
	 =?ISO-8859-1?B?TC4gKEpTQy1FUikgKExNKQ==?= 
	<corbin.l.holtz1@jsc.nasa.gov>
Cc: =?ISO-8859-1?B?J2xpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcn?= 
	<linux-kernel@vger.kernel.org>
Subject: Re: Disable kscand/Normal?
Date: Thu, 26 Aug 2004 15:32:02 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HOLTZ, CORBIN L. (JSC-ER) (LM) writes:

> Hello,
> 
> Sorry to post to the list without being subscribed, but I've searched the
> web for information on this and I can't find anything useful.  I'm currenty
> building a realtime visualization system for a Space Shuttle landing
> simulator at NASA.  I'm using a small network of 5 Pentium 4 computers
> running RedHat's 2.4.20-31.9 kernel.  I'm easily running 60 frames/second on
> my systems, but I'm having a problem because the kscand/Normal thread comes
> in every 25 seconds and causes me to drop a frame (very annoying).  I've
> looked into the kernel source and found where the kscand threads are
> spawned.  I also see where the 25 second period is coming from.  What I'm
> wondering is what would happen if I disabled the kscand/Normal thread?  I've
> got plenty of memory, and my process is the only thing running on the
> system.  Would I eventually see problems, or would I be OK since I'm not
> running low on memory?  What if I modified the kernel to allow me to
> temporarily disable the thread while my application is running (using a
> /proc file or something similar)?  Sorry if this is a bad question, but I
> figure the people on this list are the best source of info.
> 
> Please CC: me directly since I'm not subscribed to the list. 

That vendor kernel that you're running has the rmap vm which has the kscand 
daemon. If you build a newer vanilla kernel it will not have the kscand 
daemon. Alternatively, you can manually nice the the kscand daemon as root 
to a lower value (not sure what it is by default) say nice +19. You can also 
rebuild your vendor's kernel and edit the code to set the nice level 
on spawning the daemon (obviously this requires more knowledge than the 
previous options).

Cheers,
Con

