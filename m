Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263525AbTJWKRo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 06:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263531AbTJWKRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 06:17:44 -0400
Received: from data.iemw.tuwien.ac.at ([128.131.70.3]:10629 "EHLO
	data.iemw.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S263525AbTJWKRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 06:17:43 -0400
Message-ID: <3F97AACB.2020609@tuwien.ac.at>
Date: Thu, 23 Oct 2003 12:17:47 +0200
From: Samuel Kvasnica <samuel.kvasnica@tuwien.ac.at>
Organization: IEMW TU-Wien
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, de-at, cs
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Vitez Gabor <gabor@swszl.szkp.uni-miskolc.hu>,
       ivtv-devel@lists.sourceforge.net
Subject: Re: nforce2 random lockups - still no solution ?
References: <3F95748E.8020202@tuwien.ac.at> <200310211113.00326.lkml@lpbproductions.com> <20031022085449.GA21393@swszl.szkp.uni-miskolc.hu> <3F96847C.4000506@tuwien.ac.at> <20031022133327.GA25283@swszl.szkp.uni-miskolc.hu>
In-Reply-To: <20031022133327.GA25283@swszl.szkp.uni-miskolc.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Gabor,

thantks a lot, indeed you are right ! I've been confused by some nforce 
FAQs where 'nolapic' option was recommended. In fact I did never check 
whether this option
really exists. Now, after recompiling the kernel the framegrabber works 
with uncompressed stream for almost 24h and it is rock-solid.

So, a workaround recommendation for all using ivtv driver on nforce2 
chipsets and kernels up to 2.4.22:

*** RECOMPILE YOUR KERNEL WITH LOCAL APIC DISABLED ***,

otherwise you'll experience very rare random lockups while watching the 
compressed stream and lockups within 10 minutes when watching the 
uncompressed
yuv stream.

What I'd like to know is whether this bug is AMD processor or chipset 
related. Is there a patch available ? I tried 2.6.0-test8 and it wasn't 
stable. I'd prefer to use APIC instead of XT-PIC because some drivers 
e.g. kernel DRM don't support shared interrupts and I can't get own 
interrupt for the video card.

Sam


Vitez Gabor wrote:

>Hi,
>
>On Wed, Oct 22, 2003 at 03:22:04PM +0200, Samuel Kvasnica wrote:
>  
>
>>I'm booting the kernel with acpi=off, noapic and nolapic options and 
>>    
>>
>
>nolapic? That's not a valid kernel command line parameter I'm afraid. 
>
>fgrep -ri nolapic $KERNEL_SOURCE_DIR
>
>gives nothing. ???
>
>
>	Gabor
>  
>

