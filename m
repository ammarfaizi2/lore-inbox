Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262763AbVCDDgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbVCDDgE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 22:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262844AbVCDDcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 22:32:52 -0500
Received: from fire.osdl.org ([65.172.181.4]:34694 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262565AbVCDDHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 22:07:49 -0500
Message-ID: <4227CE34.2040805@osdl.org>
Date: Thu, 03 Mar 2005 18:55:48 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: Re: 2.6.11 vs DVB cx88 stuffs
References: <200503032119.04675.gene.heskett@verizon.net>
In-Reply-To: <200503032119.04675.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> Greetings;
> 
> I've a new pcHDTV-3000 card, and I thought maybe it would
> be a good idea to build the cx88 stuff in the DVB section
> of a make xconfig.
> 
> It doesn't build, spitting out this bailout:
> 
>   CC [M]  drivers/media/video/cx88/cx88-cards.o
> drivers/media/video/cx88/cx88-cards.c: In function `hauppauge_eeprom_dvb':
> drivers/media/video/cx88/cx88-cards.c:694: error: `PLLTYPE_DTT7595' undeclared (first use in this function)
> drivers/media/video/cx88/cx88-cards.c:694: error: (Each undeclared identifier is reported only once
> drivers/media/video/cx88/cx88-cards.c:694: error: for each function it appears in.)
> drivers/media/video/cx88/cx88-cards.c:698: error: `PLLTYPE_DTT7592' undeclared (first use in this function)
> drivers/media/video/cx88/cx88-cards.c: In function `cx88_card_setup':
> drivers/media/video/cx88/cx88-cards.c:856: error: `PLLTYPE_DTT7579' undeclared (first use in this function)
> make[4]: *** [drivers/media/video/cx88/cx88-cards.o] Error 1
> make[3]: *** [drivers/media/video/cx88] Error 2
> make[2]: *** [drivers/media/video] Error 2
> 
> This is from a freshly unpacked src tree for 2.6.11, with only the
> bk-ieee1394 patch applied.  That doesn't touch this.
> 
> Comments?
> 
> Another patch needed maybe?

Sure, some patch is needed.  Let's ask the maintainer (cc-ed).

BTW, to get this you had to enable CONFIG_BROKEN:

config VIDEO_CX88_DVB
         tristate "DVB Support for cx2388x based TV cards"
         depends on VIDEO_CX88 && DVB_CORE && BROKEN
         select VIDEO_BUF_DVB


-- 
~Randy
