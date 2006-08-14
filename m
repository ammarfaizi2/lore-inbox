Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWHNRpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWHNRpn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 13:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWHNRpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 13:45:43 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:1677 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S932254AbWHNRpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 13:45:42 -0400
Message-ID: <44E0B72C.6010503@free.fr>
Date: Mon, 14 Aug 2006 19:47:24 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.4) Gecko/20060405 SeaMonkey/1.0.2
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Kernel development list <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm1: eth0: trigger_send() called with the transmitter
 busy
References: <20060813012454.f1d52189.akpm@osdl.org>	<44E08AF7.9060508@free.fr> <20060814095016.04d178ab.akpm@osdl.org>
In-Reply-To: <20060814095016.04d178ab.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le 14.08.2006 18:50, Andrew Morton a écrit :
> On Mon, 14 Aug 2006 16:38:47 +0200
> Laurent Riffard <laurent.riffard@free.fr> wrote:
> 
>> Le 13.08.2006 10:24, Andrew Morton a __crit :
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
>> Hello,
>>
>> This morning, while trying to suspend to disk, my box started to loop 
>> displaying the following message:
>> eth0: trigger_send() called with the transmitter busy.
>>
>> Here is the scenario. I booted 2.6.18-rc4-mm1 with this command line:
>> root=/dev/vglinux1/lvroot video=vesafb:ywrap,mtrr splash=silent resume=/dev/hdb7 netconsole=@192.163.0.3/,@192.168.0.1/00:0E:9B:91:ED:72 init 1
>>
>> Then I issued:
>> # echo 6 > /proc/sys/kernel/printk
>> # echo disk > /sys/power/state
> 
> ne2k isn't <ahem> the most actively-maintained driver.
> 
> But most (I think all) net drivers have problems during suspend when
> netconsole is active.  Does disabling netconsole help?

Yes it does. 
 
> Did this operation work OK in earlier kernels, with netconsole enabled?

It's the first time I see such a message. I can't speak for 2.6.18-rc3-mm2 
because it could not suspend at all (did hang right after 
"echo disk > /sys/power/state"), but it worked in earlier kernels.

I'll try with plain 2.6.18-rc4.
-- 
laurent

