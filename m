Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbVLIGgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbVLIGgN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 01:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbVLIGgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 01:36:13 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:33285 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751292AbVLIGgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 01:36:13 -0500
Date: Fri, 9 Dec 2005 07:36:08 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Conio sandiago <coniodiago@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Urgent work ! please help
Message-ID: <20051209063608.GD15993@alpha.home.local>
References: <993d182d0512070225kbc4d926w5ab4255e4cdaea75@mail.gmail.com> <20051207213547.GA15993@alpha.home.local> <993d182d0512082152xd76065aydfc7548e9f51ed94@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <993d182d0512082152xd76065aydfc7548e9f51ed94@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 11:22:47AM +0530, Conio sandiago wrote:
> Hello Willy,
> Thanks a lot for reply.
> i have done some more investigation and now i have the following observation:-
> 
> 
> 1) When i analyse the packets using ethereal,
> i saw some duplicate Acks from the reciever, after which
> transmitter does fast -re transmission,
> In this transmission i saw some TCP checksum incorrect messages.
> 
> 
> 
> 2) Now if i disbale the DCACHE in the system , And then do the ftp,
> everything works well.
> 
> 
> 
> No my doubt is
> 
> a) When does a transmitte do Fast Retransmission,?

when there is a high packet loss rate

> b) if i disbale the cache then system performance goes very slow,
> thats why everything goes well,

so probably you have a timeing problem in your driver. Maybe you
has to wait milliseconds somewhere and you wait microseconds instead,
or something like this.

> c) what is the case of collsion in the ethernet driver??

I don't understand your question. It's not the driver which makes
ethernet collisions. Collisions happen when several ethernet
transmitters send simultaneously on the same bus (hub).
 
> Please help
> Thanks in advance
> conio

Willy

