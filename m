Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbTCFTml>; Thu, 6 Mar 2003 14:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268198AbTCFTml>; Thu, 6 Mar 2003 14:42:41 -0500
Received: from flrtn-2-m1-133.vnnyca.adelphia.net ([24.55.67.133]:54400 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S261868AbTCFTmk>;
	Thu, 6 Mar 2003 14:42:40 -0500
Message-ID: <3E67A729.5050403@tmsusa.com>
Date: Thu, 06 Mar 2003 11:53:13 -0800
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01 (NSCD7.01)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops in 2.5.64
References: <3E66E782.5010502@tmsusa.com> <b487vc$1u6$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>In article <3E66E782.5010502@tmsusa.com>, J Sloan  <joe@tmsusa.com> wrote:
>  
>
>>2.5.64 was running well, but after a day
>>or so of uptime, in fairly busy use (squid,
>>postfix, dhcp server, iptables, X desktop)
>>I ssh'd in as root, issued an init 3, then
>>a moment later, init 5. A moment after
>>that, the ssh session froze and all internet
>>access stopped as well.
>>
>>The console was frozen, with an oops -
>>    
>>
>
>Are you using DRI? There is some evidence that exiting and restarting X
>will not correctly re-initialize the DRI stuff in the kernel, and
>_massive_ kernel memory corruption can ensure when the new X server
>starts. 
>
Yes, of course, I want altlantis to look _good_

>
>At which point you'll get random oopses etc.
>
That does indeed seem to be the scenario - it
was rock solid and busy for a day, but when X
was killed and restarted everything went right
to hell -

>Looks like you at least have the DRI kernel modules there.
>
>Try to see if the problem goes away if you start X without DRI support
>(ie remove the "Load 'dri'" or whatever from the XF86Config file, or
>start up in a mode that DRI doesn't support, like 8bpp).
>  
>
OK, I'll try it like that -

Joe

