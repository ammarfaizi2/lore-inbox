Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbTJWMlF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 08:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263571AbTJWMlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 08:41:05 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:14867 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S263568AbTJWMlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 08:41:01 -0400
Message-ID: <3F97CEE3.2050700@superbug.demon.co.uk>
Date: Thu, 23 Oct 2003 13:51:47 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031019 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Samuel Kvasnica <samuel.kvasnica@tuwien.ac.at>
CC: linux-kernel@vger.kernel.org,
       Vitez Gabor <gabor@swszl.szkp.uni-miskolc.hu>,
       ivtv-devel@lists.sourceforge.net
Subject: Re: nforce2 random lockups - still no solution ?
References: <3F95748E.8020202@tuwien.ac.at> <200310211113.00326.lkml@lpbproductions.com> <20031022085449.GA21393@swszl.szkp.uni-miskolc.hu> <3F96847C.4000506@tuwien.ac.at> <20031022133327.GA25283@swszl.szkp.uni-miskolc.hu> <3F97AACB.2020609@tuwien.ac.at>
In-Reply-To: <3F97AACB.2020609@tuwien.ac.at>
X-Enigmail-Version: 0.81.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Kvasnica wrote:
> Dear Gabor,
> 
> thantks a lot, indeed you are right ! I've been confused by some nforce 
> FAQs where 'nolapic' option was recommended. In fact I did never check 
> whether this option
> really exists. Now, after recompiling the kernel the framegrabber works 
> with uncompressed stream for almost 24h and it is rock-solid.
> 
> So, a workaround recommendation for all using ivtv driver on nforce2 
> chipsets and kernels up to 2.4.22:
> 
> *** RECOMPILE YOUR KERNEL WITH LOCAL APIC DISABLED ***,
> 
> otherwise you'll experience very rare random lockups while watching the 
> compressed stream and lockups within 10 minutes when watching the 
> uncompressed
> yuv stream.
> 
> What I'd like to know is whether this bug is AMD processor or chipset 
> related. Is there a patch available ? I tried 2.6.0-test8 and it wasn't 
> stable. I'd prefer to use APIC instead of XT-PIC because some drivers 
> e.g. kernel DRM don't support shared interrupts and I can't get own 
> interrupt for the video card.
> 
> Sam
> 
> 
> Vitez Gabor wrote:
> 
>> Hi,
>>
>> On Wed, Oct 22, 2003 at 03:22:04PM +0200, Samuel Kvasnica wrote:
>>  
>>
>>> I'm booting the kernel with acpi=off, noapic and nolapic options and   
>>
>>
>> nolapic? That's not a valid kernel command line parameter I'm afraid.
>> fgrep -ri nolapic $KERNEL_SOURCE_DIR
>>
>> gives nothing. ???
>>
>>
>>     Gabor
>>  

Extract fron linux-2.6test8 Documentation/kernel-parameters.txt
nolapic   [IA-32,APIC] Do not enable or use the local APIC.

So, It is supported in the kernel 2.6.x

Cheers
James

