Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262560AbVCVIYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbVCVIYD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 03:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbVCVIYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 03:24:03 -0500
Received: from post.tau.ac.il ([132.66.16.11]:2689 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S262557AbVCVIXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 03:23:51 -0500
Date: Tue, 22 Mar 2005 10:23:48 +0200 (IST)
From: Hayim Shaul <hayim@post.tau.ac.il>
X-X-Sender: hayim@nova.cs.tau.ac.il
To: Arjan van de Ven <arjan@infradead.org>
Cc: Gleb Natapov <gleb@minantech.com>, linux-kernel@vger.kernel.org
Subject: Re: mmap/munmap bug
In-Reply-To: <1111478733.7096.36.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0503221015500.10609@nova.cs.tau.ac.il>
References: <Pine.LNX.4.61.0503211731430.9160@nova.cs.tau.ac.il> 
 <1111430042.6952.70.camel@laptopd505.fenrus.org>  <20050322075658.GA32445@minantech.com>
 <1111478733.7096.36.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Does it support zero copy not only for send but also for receive? Can we
>> receive packets directly to userspace buffers?
>
> that it can't currently, but without some major protocol stack rework
> that's not going to be easy. If you want to help do that work,
> excellent! Be sure to contact the people on net-dev mailinglist since
> they are the ones having looked at this previously.

My case is simpler, as the application I attend it to is similar to a NAT. 
A packet comes in, a little alternation of the headers and off it goes 
again. So there's no TCP-stack or anything.

What I thought of doing, is map the skbuff to user-space. Have the 
user-application alter the headers. Send the (same) skbuff from 
kernel-space.

Does there exist anything equivalent?

