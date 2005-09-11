Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965026AbVIKSYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbVIKSYr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 14:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbVIKSYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 14:24:46 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:20202 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S965028AbVIKSYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 14:24:45 -0400
Message-ID: <4324766B.70107@gentoo.org>
Date: Sun, 11 Sep 2005 19:24:43 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050820)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kasper Peeters <kasper.peeters@aei.mpg.de>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: crash upon rmmod aic7xxx (pcmcia)
References: <17188.9683.311780.197075@sbox13.aei.mpg.de>	<432444B6.7070309@gentoo.org> <17188.28765.826177.728033@sbox13.aei.mpg.de>
In-Reply-To: <17188.28765.826177.728033@sbox13.aei.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please use reply-to-all)

Kasper Peeters wrote:
>>Try enabling magic sysrq and press Alt+sysrq+9 then Alt+SysRq+P 
> 
> 
> I just spent an hour trying to make this work: it's turned on in the
> kernel, I have done
> 
>   echo '1' > /proc/sys/kernel/sysrq
> 
> , I have done a 'showkey -s' to find out that my sysrq generates
> '0x53', I have done 'setkeycodes 53 84', but none of the
> alt-sysrq-command things does anything (even before triggering the
> aic7xxx bug, that is). I must have overlooked something stupid.
> 
> Anyhow, for what it's worth, the 'rmmod' does spit out some more stuff
> to the console just before the crash (inasfar it has not yet scrolled
> off the screen):
> 
>   Sequencer Free SCB List 0 1 2
>   Sequencer SCB Info
>     0 SCB_CONTROL[0x0]:SCB_SCSIID[0x67]:SCB_LOW[0x0]:SCB_TAG[0xff]
>     1 SCB_CONTROL[0x0]:SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TIB)SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID)SCB_TAG[0xff]
>     2 SCB_CONTROL[0x0]:SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TIB)SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID)SCB_TAG[0xff]
>   Pending List:
>     2 SCB_CONTROL[0x40]:(DISCENB)SCB_SCSIID[0x47]:SCB_LUN[0x0]
>   Kernel Free SCB List: 1 0
>   Untagged Q(4):2
>   
>   <<< Dump Card State End >>>
>   qindex = 0, SCB index=0
>   Kernel Panic - not syncing: Loop 1
> 

Ok, if its a kernel panic then I'm fairly sure sysrq would be useless for 
debugging even if it worked on your setup. Also, this is the exact same 
message from the Gentoo bug that I mentioned previously: 
http://bugs.gentoo.org/102636

Perhaps you could file a bug for this at http://bugzilla.kernel.org and I'll 
get the Gentoo bug reporter to post his experience on your bug too.

Thanks,
Daniel
