Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263883AbTH1KKX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 06:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbTH1KHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 06:07:36 -0400
Received: from mail-06.iinet.net.au ([203.59.3.38]:37077 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262312AbTH1J3Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 05:29:25 -0400
Message-ID: <3F4DCB6D.5030608@cyberone.com.au>
Date: Thu, 28 Aug 2003 19:29:17 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: Samium Gromoff <deepfire@ibe.miee.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Nick's scheduler policy v8
References: <878ypexkb2.wl%deepfire@ibe.miee.ru>
In-Reply-To: <878ypexkb2.wl%deepfire@ibe.miee.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Samium Gromoff wrote:

>>It seems to be better than v7 here without X being reniced,
>>however renicing X to say -10 always seems to help.
>>
>
>	On my box renicing X to -10 causes xmms to skip when i switch
> to a next page full of text in xpdf.
> This is about mainline, not sure about your patch.
>
> And yes, my box is p3-500.
>
>	So i generally don`t think it`s wise to renice X to -10.
>

Well I won't say it won't happen with my patch, but nice is a lot
nicer. Give it a try.

No, it wouldn't be wise to renice X to -10 if it caused it to
starve xmms. I don't think that will happen in my version, so I
think it is reasonable to renice X if you know it will have to
do more work than other tasks and yet should still be scheduled
quickly for good interactivity...


