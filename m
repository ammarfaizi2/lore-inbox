Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266339AbUGUO0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266339AbUGUO0I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 10:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266391AbUGUO0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 10:26:08 -0400
Received: from dns.gardena.net ([213.21.177.18]:1710 "HELO dns.gardena.net")
	by vger.kernel.org with SMTP id S266339AbUGUO0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 10:26:02 -0400
Message-ID: <40FE7D4B.3080904@gardena.net>
Date: Wed, 21 Jul 2004 16:27:23 +0200
From: Benno Senoner <sbenno@gardena.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040421
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "The Linux Audio Developers' Mailing List" 
	<linux-audio-dev@music.columbia.edu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary	Kernel	Preemption
 Patch
References: <20040712163141.31ef1ad6.akpm@osdl.org>	<1090306769.22521.32.camel@mindpipe> <20040720071136.GA28696@elte.hu>	<200407202011.20558.musical_snake@gmx.de>	<1090353405.28175.21.camel@mindpipe>  <40FDAF86.10104@gardena.net> <1090369957.841.14.camel@mindpipe>
In-Reply-To: <1090369957.841.14.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

>anyway.
>
>
>  
>
>>Plus what's very important is that every kernel developer and driver 
>>developer (even thirdparty, especially those
>>that do closed source stuff like Nvidia etc) takes into account the 
>>latency problems that code paths that run for
>>too long time (or disable IRQs for too long etc) might create.
>>While I'm not a kernel expert I assume the premptible kernel alleviates 
>>this problem but I guess it still cannot
>>completely get rid of low latency-unfriendly routines and drivers.
>>    
>>
>
>Yes, this is important.  One problem I had recently with the Via EPIA
>board was that unless 2D acceleration was disabled by setting 'Option
>"NoAccel"' in /etc/X11/XF86Config-4, overloading the X server would
>cause interrupts from the soundcard to be completely disabled for tens
>of milliseconds.  Users should keep in mind that by using 2D or 3D
>hardware acceleration in X, you are allowing the X server to directly
>access hardware, which can have very bad results if the driver is
>buggy.  I am not sure the kernel can do anything about this.
>  
>

that's bad news.
VIA markets those mini-itx mainboards (with onboard audio/video/network) 
as multimedia appliances and
therefore I'd expect the hardware providing low latencies  when both 
video acceleration and audio is used.
Hopefully only a driver issue (as in most of cases)

Since VIA released the unichrome (the gfx chipset contained in their 
mainboards) sources someone should
contact these folks :
http://unichrome.sourceforge.net/
to check what is causing those latency spikes ?
Any unichrome developer lurking on LKML ?

cheers,
Benno
http://www.linuxsampler.org

>Lee
>
>
>  
>

