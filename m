Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbTD3Tzo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 15:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262414AbTD3Tzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 15:55:44 -0400
Received: from lakemtao03.cox.net ([68.1.17.242]:57493 "EHLO
	lakemtao03.cox.net") by vger.kernel.org with ESMTP id S262413AbTD3Tzk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 15:55:40 -0400
Message-ID: <3EB02D0F.1080101@cox.net>
Date: Wed, 30 Apr 2003 15:07:43 -0500
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andersen@codepoet.org
CC: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ALSA and 2.4.x
References: <20030424212508.GI14661@codepoet.org> <200304251401.36430.m.c.p@wolk-project.de> <200304251410.31701.m.c.p@wolk-project.de> <20030430090242.GA15480@codepoet.org>
In-Reply-To: <20030430090242.GA15480@codepoet.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:
> On Fri Apr 25, 2003 at 02:10:31PM +0200, Marc-Christian Petersen wrote:
> 
>>On Friday 25 April 2003 14:01, Marc-Christian Petersen wrote:
>>
>>Hi again,
>>
>>
>>>>I was crazy enough to take ALSA 0.9.2 and made it into a patch vs
>>>>2.4.x a week or two ago.  I just prefer to have ALSA be part of
>>>>the kernel rather than needing to compile it seperately all the
>>>>time.  The patch, along with various other things, is included as
>>>>part of my 2.4.21-rc1-erik kernel:
>>>
>>>Are you sure that this is 0.9.2 ALSA? I am afraid it is 0.9.0-rc6.
>>
>>this looks _very_ similar to the patch I had in WOLK4 some time ago and it was 
>>0.9.0-rc6.
> 
> 
> I finally got a bit of time this morning, so I have now updated
> my patch set.  I check very carefully and made sure I generated
> my ALSA 0.9.2 patch from the correct kernel tree this time, so 
> it actually contains my 0.9.2 port this time.
> 
>     http://codepoet.org/kernel/
> 
> Sorry about having the wrong alsa patch in there last time.  Last
> time around I has accidentlly built my alsa patch from my older
> alsa kernel tree.  I have this built into my kernel and I now see 
> 
>     Partition check:
>      hda: hda1 hda2
>     Advanced Linux Sound Architecture Driver Version 0.9.2.
>     PCI: Setting latency timer of device 00:11.5 to 64
>     ALSA device list:
>       #0: VIA 8233 at 0xcc00, irq 5
> 
> on bootup and xmms is playing.  Hope this is helpful,

I'm getting an unresolved in soundcore.o that is preventing me from 
having sound.
/lib/modules/2.4.21-rc1/kernel/sound/soundcore.o: unresolved symbol 
devfs_remove
/lib/modules/2.4.21-rc1/kernel/sound/soundcore.o: insmod 
/lib/modules/2.4.21-rc1/kernel/sound/soundcore.o failed
/lib/modules/2.4.21-rc1/kernel/sound/soundcore.o: insmod snd-card-0 failed

Can that be fixed?
Also I have problems if I compile USB Audio and USB MIDI from the USB 
section AND USB Audio and USB MIDI from the ALSA section. Compilation 
fails in that situation. Might want to put the former patch up if this 
stuff might take a while to fix.

Thanks,
David

