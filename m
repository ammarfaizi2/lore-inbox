Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbUAPACO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 19:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265209AbUAPACO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 19:02:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:48819 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264537AbUAPACJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 19:02:09 -0500
X-Authenticated: #4512188
Message-ID: <400729FE.6030607@gmx.de>
Date: Fri, 16 Jan 2004 01:02:06 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Drake <dan@reactivated.net>
CC: ross@datscreative.com.au, Jesse Allen <the3dfxdude@hotmail.com>,
       Ian Kumlien <pomac@vapor.com>, linux-kernel@vger.kernel.org
Subject: Re: NForce2, Ross Dickson's timer patch on 2.6.1
References: <200401140256.30727.ross@datscreative.com.au> <40072EDC.2050604@reactivated.net>
In-Reply-To: <40072EDC.2050604@reactivated.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But, there might be more to it. I had forgotten up until now, but I am 
> using this code in my /etc/conf.d/local.start :
> setpci -v -H1 -s 0:0.0 6F=$(printf %x $((0x$(setpci -H1 -s 0:0.0 6F) | 
> 0x10)))
> 
> and this one in /etc/conf.d/local.stop :
> setpci -v -H1 -s 0:0.0 6F=$(printf %x $((0x$(setpci -H1 -s 0:0.0 6F) & 
> 0xef)))
> 
> I got these codes from 
> http://www.tldp.org/HOWTO/Athlon-Powersaving-HOWTO/approaches.html#commandline 

Well you are putting disconnect to "on" on boot and "off" on shutdown, 
if I am not mistaken. The quirk wanted to take it turn it off on boot 
time, so strange it lead to locking to you. I have locking problems 
intorduced with 2.6.1 mm line. Trying to find out, what is the case...

I haven't tried Ross' patches, btw.

Prakash
