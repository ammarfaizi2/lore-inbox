Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751639AbVIZOjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbVIZOjE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 10:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbVIZOjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 10:39:04 -0400
Received: from host27-37.discord.birch.net ([65.16.27.37]:28291 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S1751639AbVIZOjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 10:39:00 -0400
From: "Roger Heflin" <rheflin@atipa.com>
To: "'Al Boldi'" <a1426z@gawab.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Resource limits
Date: Mon, 26 Sep 2005 09:44:15 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcXB25YWH4EvWf80ShucshA6be5bMgAytLaQ
In-Reply-To: <200509251712.42302.a1426z@gawab.com>
Message-ID: <EXCHG2003ogxLDp7mvj00000ae4@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 26 Sep 2005 14:35:03.0870 (UTC) FILETIME=[7B9645E0:01C5C2A7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While talking about limits, one of my customers report that if
they set "ulimit -d" to be say 8GB, and then a program goes and
attempts to allocate 16GB (in one shot), that the process will
hang on the 16GB allocate as the machine does not have enough
memory+swap to handle this, the process is at this time unkillable,
the customers method to kill the process is to send the process
a kill signal, and then create enough swap to be able to meet
the request, after the request is filled the process terminates.

It would seem that the best thing to do would be to abort on
allocates that will by themselves exceed the limit.

This was a custom version of a earlier version of the 2.6 kernel, 
I would bet that this has not changed in quite a while.

                        Roger


> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Al Boldi
> Sent: Sunday, September 25, 2005 9:13 AM
> To: linux-kernel@vger.kernel.org
> Subject: Resource limits
> 
> 
> Resource limits in Linux, when available, are currently very limited.
> 
> i.e.:
> Too many process forks and your system may crash.
> This can be capped with threads-max, but may lead you into a lock-out.
> 
> What is needed is a soft, hard, and a special emergency limit 
> that would allow you to use the resource for a limited time 
> to circumvent a lock-out.
> 
> Would this be difficult to implement?
> 
> Thanks!
> 
> --
> Al
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

