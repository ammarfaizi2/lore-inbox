Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275597AbRI1BRY>; Thu, 27 Sep 2001 21:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275615AbRI1BRO>; Thu, 27 Sep 2001 21:17:14 -0400
Received: from razor.hemmet.chalmers.se ([193.11.251.99]:10368 "EHLO
	razor.hemmet.chalmers.se") by vger.kernel.org with ESMTP
	id <S275597AbRI1BRG>; Thu, 27 Sep 2001 21:17:06 -0400
Message-ID: <3BB3CF56.8040904@kjellander.com>
Date: Fri, 28 Sep 2001 03:16:06 +0200
From: Carl-Johan Kjellander <carljohan@kjellander.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4+) Gecko/20010925
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10 crashes hard when starting X.
In-Reply-To: <3BB28FC6.9090404@kjellander.com> <20010926225507.A23915@cs.cmu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Harkes wrote:

> On Thu, Sep 27, 2001 at 04:32:38AM +0200, Carl-Johan Kjellander wrote:
> 
>>When I tried 2.4.10 my machine crashed really hard upon starting the
>>Xserver, not even alt-sysrq-SU worked, but alt-sysrq-B did reboot the
>>machine. I've been trying divide and conquer to find out which kernel
>>that crashes my machine from 2.4.8 and 2.4.10.
>>
> ...
> 
>>Modules Loaded         binfmt_misc tuner tvaudio bttv microcode pwcx pwc
>>  usbmouse nfs lockd sunrpc autofs 8139too ipchains vfat fat ntfs es1371
>>  ac97_codec soundcore mousedev hid usb-uhci usbcore
>>
> 
> Hmm, usbmodules loaded, I reported earlier to l-k that a patch that went
> into include/linux/list.h was causing USB related oopses.
> 
> In list_del the second line (entry->next = entry->prev = 0) is evil.
> Remove that line and rebuild the kernel & modules and maybe...

2.4.10-pre8 doesn't have that line and today I got lockup with -pre8 as well.
This happened when  the daily cronjobs were running.

So far:

2.4.8        works fine
2.4.9        works fine
2.4.10-pre8  crashes when updatedb or tripwire runs.
2.4.10       crashes hard upon X startup.

/Carl-Johan Kjellander

-- 
begin 644 carljohan_at_kjellander_dot_com.gif
Y1TE&.#=A(0`F`(```````/___RP`````(0`F```"@XR/!\N<#U.;+MI`<[U(>\!UGQ9BGT%>'D2I
Y*=NX,2@OUF2&<827ILW;^822C>\7!!Z1,!K'B5(6H<SH-"E*TJ3%*/>QI6:7"A>Y?):D2^*U@NCV
R<MOQ=]V(B6>LZYD-_T1U<@3W]A4(^$-W4]A#V")W6#.R"$;IR'@).46BN7$9>5D``#L`

