Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264614AbSLUTkx>; Sat, 21 Dec 2002 14:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264617AbSLUTkw>; Sat, 21 Dec 2002 14:40:52 -0500
Received: from 115.8.237.216.globalpac.com ([216.237.8.115]:61370 "EHLO
	mail.yessos.com") by vger.kernel.org with ESMTP id <S264614AbSLUTkv>;
	Sat, 21 Dec 2002 14:40:51 -0500
Message-ID: <3E04C5A8.6050204@tmsusa.com>
Date: Sat, 21 Dec 2002 11:48:56 -0800
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Partial Success with 2.5.52bk6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgive me if any of this is old news -

I loaded up 2.5.52bk6 on a couple of systems here and took it
for a spin - both systems had previously run 2.4.18-RH, 2.4.19-aa,
and 2.4.19/20-ckX

I found it rather impressive - subjectively speaking, the 2.5 kernel
had a snappier feel on the desktop. Mozilla page scrolling remained
smooth while loading a page with many images on 2.5, while scrolling
stuttered and hesitated while loading the same page on 2.4.20-ck2.

2.5 also remained usable while running dbench or ltp -

On the down side, modules that loaded automatically under 2.4 now
have to be manually loaded - for instance my iptables script has
to now first manually load each and every needed module before it
issues any iptables commands or it dies - 2.4 automagically loaded
the required modules.

And now we come to the little show stopper - one of my systems has
an intel motherboard with built-in i810 video. I can manually load
the agp module, but it yields a cosmetic oops:

[drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Uninitialised timer!
This is just a warning.  Your computer is OK
function=0x00000000, data=0x0
Call Trace:
 [<c011fd01>] check_timer_failed+0x61/0x70
 [<c011fffc>] del_timer+0x1c/0x80
 [<e095a648>] i830_takedown+0x38/0x3e0 [i830]
 [<e095f3f5>] i830_stub_unregister+0x35/0x60 [i830]
 [<e092123f>] 0xe092123f
 [<e09621e8>] __func__.30+0x0/0x9 [i830]
 [<c012b474>] sys_init_module+0x1a4/0x1c0
 [<c01095eb>] syscall_call+0x7/0xb


More seriously, any attempt to load the i810 drm module fails:

# modprobe i810
FATAL: Error inserting i810 
(/lib/modules/2.5.52bk6/kernel/drivers/char/drm/i810.ko): Cannot 
allocate memory


Any hope for i810 drm soon?  Other than that it's looking sweet here.

Kudos for an awesome kernel in the making!

Best Regards,

Joe


