Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262596AbVCVJoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbVCVJoX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 04:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVCVJoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 04:44:23 -0500
Received: from post.tau.ac.il ([132.66.16.11]:7096 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S262596AbVCVJoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 04:44:21 -0500
Date: Tue, 22 Mar 2005 11:44:20 +0200 (IST)
From: Hayim Shaul <hayim@post.tau.ac.il>
X-X-Sender: hayim@nova.cs.tau.ac.il
To: Arjan van de Ven <arjan@infradead.org>
Cc: Gleb Natapov <gleb@minantech.com>, linux-kernel@vger.kernel.org
Subject: Re: mmap/munmap bug
In-Reply-To: <1111480429.7096.47.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0503221140150.15767@nova.cs.tau.ac.il>
References: <Pine.LNX.4.61.0503211731430.9160@nova.cs.tau.ac.il> 
 <1111430042.6952.70.camel@laptopd505.fenrus.org>  <20050322075658.GA32445@minantech.com>
  <1111478733.7096.36.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.61.0503221015500.10609@nova.cs.tau.ac.il>
 <1111480429.7096.47.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> What I thought of doing, is map the skbuff to user-space. Have the
>> user-application alter the headers. Send the (same) skbuff from
>> kernel-space.
>>
>> Does there exist anything equivalent?
>
> yes; netfilter has facilities for this actually afaik.
> tcpdump also uses something like this (but only in one direction), it
> mmaps some ringbuffer with incomming packets.

Are you refering to NF_QUEUE + libipq ?
I was under the impression that it does involve memcpy.

Also, I think that with this you cannot change routing decisions made on 
the packet, although, I'm not sure yet how critical this is for me.
