Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262272AbVGWBz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbVGWBz1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 21:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVGWBz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 21:55:27 -0400
Received: from wifi.tel-ott.com ([72.1.193.4]:47585 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262272AbVGWBzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 21:55:25 -0400
Message-ID: <42E1A38C.80806@trash.net>
Date: Sat, 23 Jul 2005 03:55:24 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: k8 s <uint32@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Is this a bug in linux-2.6.12 ipsec code function xfrm4_rcv_encap
 ??
References: <699a19ea0507221807220c1704@mail.gmail.com> <699a19ea050722183117eec7a9@mail.gmail.com>
In-Reply-To: <699a19ea050722183117eec7a9@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

k8 s wrote:
> I AM SORRY FOR THE PREVIOUS MAIL.
> I am correcting my previous mail. 
> Infact I see only One race(not three as was wrongly pointed out).
> I commented out the section once again where the race might be.
> 
>  /********************************************************
>  Race Here . The Check(x->props.mode) is without Lock. What if setkey
> -F is done at the same time on another processor freeing what x points
> to.
>  ********************************************************/
> 
>>                if (x->props.mode) {

We hold a reference to the state, so it can't be freed.
