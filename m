Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265320AbTBKEIj>; Mon, 10 Feb 2003 23:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265880AbTBKEIj>; Mon, 10 Feb 2003 23:08:39 -0500
Received: from impact.colo.mv.net ([199.125.75.20]:1970 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP
	id <S265320AbTBKEIi>; Mon, 10 Feb 2003 23:08:38 -0500
Message-ID: <3E487974.3080306@bogonomicon.net>
Date: Mon, 10 Feb 2003 22:17:56 -0600
From: Bryan Andersen <bryan@bogonomicon.net>
Organization: Bogonomicon
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: walt <wa1ter@hotmail.com>
Subject: Re: 2.4.21-pre4-ac3 hangs at reboot
References: <3E47E257.3000904@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You're not the only one hitting this.  My symptoms seam identicle to 
yours.

What do you notice about the order of messages in relationship to how 
they were ordered pre 2.4.21-pre4-ac2?  Before I would see all the 
shutdown messages then "flushing ide" then the reboot or power down 
message.  Now the reboot or power down message shows up before or 
durring the md raid device shutdown.  Then I get the flushing ide 
mesasage and it dies part way through.

walt wrote:
> Hi Alan,
> 
> Actually this problem started with ac2.  All seems to work well until I
> reboot the machine with 'shutdown' or 'reboot' or 'ctl-alt-del'.
> 
> The machine shuts down properly to the point where all filesystems
> are remounted readonly, which is the point where I normally see an
> immediate reboot.  Starting with pre4-ac2 I just get an indefinite
> hang instead of the reboot.
> 
> The terminal driver still seems to work because I can use the
> ctl-alt-Fx keys to switch to other pseudo-terminals but the login
> process is already gone so I can't actually do anything at the
> login prompts.  It takes a hard reset to complete the reboot,
> after which the machine comes up normally with clean filesystems.
> 
> I see this on three different machines with different motherboards
> and CPU's [K6-2, athlon, athlon-xp], two VIA chipsets and one SiS.
> 
> No error messages print anywhere, so I'm not sure how to debug.
> Do you need a kernel config file or dmesg output?
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


